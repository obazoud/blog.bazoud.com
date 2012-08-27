---
layout: post
title: GWT + Stripes + Hibernate4GWT
date: '2008-02-05T21:36:00.000Z'
author: Olivier
aliases: ['/post/2008/02/05/gwt-stripes-hibernate4gwt/', '/post/2008/02/05/gwt-stripes-hibernate4gwt/']
categories: [Uncategorized]
tags: [GWT,Stripes,java,Hibernate,Hibernate4gwt]
---

<p>L'intégration entre GWT / Stripes / Hibernate4gwt se fait en refactorisant l'<a href="/post/2007/12/09/GWT-Stripes">article précédent</a> et en injectant HibernateBeanManager vi l'annotation @SpringBean.</p> 
<pre class="prettyprint lang-java">
public abstract class GWTActionBean extends HibernateRemoteService implements ActionBean {
    private ActionBeanContext context;

    public GWTActionBean() {
        super();
    }

    public ActionBeanContext getContext() {
        return context;
    }

    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    @Override
    public ServletContext getServletContext() {
        return getContext().getServletContext();
    }

    @DefaultHandler
    public Resolution defaultHandler() throws ServletException {
        return new Resolution() {
            public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
                doPost(request, response);
            }
        };
    }

    /**
     * 
     */
    @Override
    @SpringBean("hibernateBeanManager")
    public void setBeanManager(HibernateBeanManager manager) {
        super.setBeanManager(manager);
    }
</pre>
