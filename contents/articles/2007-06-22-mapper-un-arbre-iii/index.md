---
template: article.jade
title: Mapper un arbre III
date: '2007-06-22T19:33:00.000Z'
author: Olivier
aliases: ['/post/2007/06/22/mapper-un-arbre-iii/', '/post/2007/06/22/mapper-un-arbre-iii/', '/post/2007/06/23/Mapper-un-arbre-iii', '/post/2007/06/23/Mapper-un-arbre-III']
categories: [Uncategorized]
tags: [jdk5,java,Hibernate,generics]
excerpt: <h3>Arbre générique</h3> <p>Nous allons voir la partie générique de l'arbre.</p>
---

<h3>Arbre générique</h3> <p>Nous allons voir la partie générique de l'arbre.</p>
<!--more-->
<p>Le principe de mon arbre est le suivant :</p> <ul> <li>1 arbre (Tree) a un nom et a une référence vers le noeud (Node) 'root'</li> <li>1 noeud (Node) a un parent, des enfants et contient une référence vers une valeur (NodeValue)</li> <li>la valeur (NodeValue)</li> </ul> 
<p>Tree :</p> 
<pre class="prettyprint lang-java">
package com.blog.tree.model;

@Entity
@Table(name = "TREE")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "type", discriminatorType = DiscriminatorType.STRING)
public abstract class Tree &lt;T extends NodeValue & Serializable&gt; implements Serializable {
        private static final long serialVersionUID = -934945451933213736L;
        private Long id;
        private Node&lt;T&gt; root;
        private String name;

        public Tree() {
                super();
        }

        @Id
        public Long getId() {
                return this.id;
        }

        public void setId(Long id) {
                this.id = id;
        }

        @OneToOne(cascade = CascadeType.ALL, targetEntity = Node.class)
        public &lt;H extends Node&lt;T&gt;&gt; H getRoot() {
                return (H) this.root;
        }

        public &lt;H extends Node&lt;T&gt;&gt; void setRoot(H root) {
                this.root = root;
        }

        public String getName() {
                return this.name;
        }

        public void setName(String name) {
                this.name = name;
        }
}
</pre>
<p>Node :</p> 
<pre class="prettyprint lang-java">
package com.blog.tree.model;

@Entity
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "type", discriminatorType = DiscriminatorType.STRING)
public abstract class Node&lt;T extends NodeValue & Serializable&gt; implements Serializable {
        private static final long serialVersionUID = -706154548349031973L;
        private Long id;
        private T nodeValue;
        private List&lt;? extends Node&lt;T&gt;&gt; children;
        private Node&lt;T&gt; root;
        private Node&lt;T&gt; parent;
        @SuppressWarnings("unused")
        private int childPosition;

        public Node() {
                super();

        }

        @Id
        public Long getId() {
                return this.id;
        }

        public void setId(Long id) {
                this.id = id;
        }

        @OneToMany(cascade = CascadeType.ALL, targetEntity = Node.class)
        @JoinColumn(name = "parentId", nullable = true)
        @OrderBy(value = "childPosition")
        public List&lt;? extends Node&lt;T&gt;&gt; getChildren() {
                return this.children;
        }

        public void setChildren(List&lt;? extends Node&lt;T&gt;&gt; children) {
                this.children = children;
        }

        @OneToOne(cascade = CascadeType.ALL, targetEntity = NodeValue.class)
        public T getNodeValue() {
                return this.nodeValue;
        }

        public void setNodeValue(T nodeValue) {
                this.nodeValue = nodeValue;
        }

        @OneToOne(targetEntity = Node.class)
        @JoinColumn(name = "rootId", nullable = false)
        public &lt;H extends Node&lt;T&gt;&gt; H getRoot() {
                return (H) this.root;
        }

        public &lt;H extends Node&lt;T&gt;&gt; void setRoot(H root) {
                this.root = root;
        }

        public int getChildPosition() {
                if (isRoot()) {
                        return -1;
                }
                List&lt;? extends Node&lt;T&gt;&gt; list = getParent().getChildren();
                return list.indexOf(this);
        }

        public void setChildPosition(int childPosition) {
                this.childPosition = childPosition;
        }

        @ManyToOne(targetEntity = Node.class)
        @JoinColumn(name = "parentId", nullable = true)
        public &lt;H extends Node&lt;T&gt;&gt; H getParent() {
                return (H) this.parent;
        }

        public &lt;H extends Node&lt;T&gt;&gt; void setParent(H parent) {
                this.parent = parent;
        }

        @Transient
        public boolean isRoot() {
                return (parent == null);
        }

        @Transient()
        public boolean isLeaf() {
                return (getChildren() == null || getChildren().size() == 0);
        }
}
</pre>
<p></p>
<pre class="prettyprint lang-java">
package com.blog.tree.model;

@Entity
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
public class NodeValue implements Serializable {
        private static final long serialVersionUID = 153631252194745635L;
        private Long id;

        public NodeValue() {
                super();
        }

        @Id
        public Long getId() {
                return this.id;
        }

        public void setId(Long id) {
                this.id = id;
        }

        @Override
        public int hashCode() {
                return new HashCodeBuilder().append(this.getId()).toHashCode();
        }

        @Override
        public boolean equals(Object obj) {
                if (this == obj) {
                        return true;
                }
                if (!(obj instanceof NodeValue)) {
                        return false;
                }
                NodeValue cast = (NodeValue) obj;
                return new EqualsBuilder().append(this.getId(), cast.getId()).isEquals();
        }
}
</pre>
