From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: down_timeout
Date: Fri, 3 Oct 2003 11:03:52 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84702C93004@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Matthew Wilcox <willy-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>, Yury Umanets <umka-nJ1KrdHEGnBBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
> [mailto:linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of 
> Matthew Wilcox
> It's still not great because it doesn't preserve ordering.  
> down_timeout()
> would be a much better primitive.  We have down_interruptible() which
> could be used for this purpose.  Something like (completely 
> uncompiled):

Yeah we proposed this 2 years ago and someone (don't remember who) shot
us down.

Regards -- Andy
