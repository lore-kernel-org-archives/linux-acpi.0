From: "Martin J. Bligh" <mbligh-/CzTsIfkJEdBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH] SMP parsing rewrite, phase 1
Date: Tue, 21 Jan 2003 11:26:17 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <298380000.1043177177@flay>
References: <F760B14C9561B941B89469F59BA3A84725A12B@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <F760B14C9561B941B89469F59BA3A84725A12B-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
Content-Disposition: inline
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

>> Would be a lot easier to read if you could seperate out the
>> renames from the rest of the patch that actually does things.
> ....
> 
> Anyways, I will take a stab at redoing the changesets the way you
> describe.

Cool, will be much easier to see what you're actually changing ;-)
 
>> Anyway, I'll give it a spin on my wierdo box, and see what happens.
> 
> Cool, thanks.

Your latest update makes the NUMA-Q work just fine ;-)
x440 will need that array fixed, I guess.

M.
