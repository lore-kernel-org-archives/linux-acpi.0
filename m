From: Andrew Morton <akpm-LL/9OlyS9hIAvxtiuMwx3w@public.gmane.org>
Subject: Re: [BK PATCH]
Date: Mon, 23 Jun 2003 00:11:43 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030623001143.0fb2c292.akpm@digeo.com>
References: <F760B14C9561B941B89469F59BA3A847E96FB3@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96FB3-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: torvalds-Lhe3bsMrZseB+jHODAdFcQ@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

"Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
> Hi Linus, please do a
> 
> 	bk pull http://linux-acpi.bkbits.net/linux-acpi
> 
> This will update the following files:
> 
>  arch/i386/kernel/setup.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> through these ChangeSets:
> 
> <agrover-qb8aLOKklSjp4P8CbLYnNQ@public.gmane.org> (03/06/22 1.1359.1.1)
>    ACPI: make it so acpismp=force works (reported by Andrew Morton)
> 

OK, thanks.

But prior to 2.5.72, CPU enumeration worked fine without acpismp=force. 
Now it is required.  How come?
