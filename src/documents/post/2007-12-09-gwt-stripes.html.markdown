---
layout: post
title: GWT + Stripes
date: '2007-12-09T20:38:00.000Z'
author: Olivier
aliases: ['/post/2007/12/09/gwt-stripes/', '/post/2007/12/09/gwt-stripes/']
categories: [Uncategorized]
tags: [GWT,Stripes]
---

<p>L'intégration entre GWT et Stripes passent par RemoteServiceServlet par défaut. Cet article propose une <a href="http://kaigrabfelder.de/en/2007/07/12/1184265360000.html">solution</a> simple mais il y a un petit bug. RemoteServiceServlet a besoin du ServletContext, il faut déléguer getServletContext() vers le context Stripes.</p> 
<pre class="prettyprint lang-java">
public abstract class GWTActionBean extends RemoteServiceServlet implements ActionBean {
    private ActionBeanContext context;

    public GWTActionBean() {
        super();
    }

    /**
     * @see net.sourceforge.stripes.action.ActionBean#getContext()
     */
    public ActionBeanContext getContext() {
        return context;
    }

    /**
     * @see net.sourceforge.stripes.action.ActionBean#setContext(net.sourceforge.stripes.action.ActionBeanContext)
     */
    public void setContext(ActionBeanContext context) {
        this.context = context;
    }

    /**
     * @see javax.servlet.GenericServlet#getServletContext()
     */
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
}
</pre>