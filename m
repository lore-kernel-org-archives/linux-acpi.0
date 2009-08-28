From: Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org>
Subject: Re: 2.6.31-rc7-git2: Reported regressions 2.6.29 -> 2.6.30
Date: Fri, 28 Aug 2009 11:32:18 +0930
Message-ID: <200908281132.19765.rusty@rustcorp.com.au>
References: <JuOd1ZASH0B.A.YGB.0zGlKB@chimera> <200908272023.21288.rusty@rustcorp.com.au> <20090827211351.f9c96bfc.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090827211351.f9c96bfc.sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Content-Disposition: inline
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Frans Pop <elendil-EIBgga6/0yRmR6Xm/wNWPw@public.gmane.org>, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, protasnb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 27 Aug 2009 08:43:51 pm Stephen Rothwell wrote:
> Hi Rusty,
> 
> On Thu, 27 Aug 2009 20:23:20 +0930 Rusty Russell <rusty-8n+1lVoiYb80n/F98K4Iww@public.gmane.org> wrote:
> >
> > > Rusty/Len: please work out why the title for that patch went silly.
> > 
> > git-quiltimport uses the patch names, and doesn't extract the title.  I
> > assume that's what Stephen uses.  I didn't rename the patch when I rewrote
> > it not to use work_on_cpu.
> 
> git quiltimport assumes "mail-like" patches, so it looks for "From:" and
> "Subject:" lines.  I guess it could be made to use the first line of the
> patch if there is no subject ...

My scripts should all handle Subject: prefixes, I can just start using that.

Thanks,
Rusty.
