From: Nigel Cunningham <ncunningham-oKK1aGe2n869koe0gwxAeg@public.gmane.org>
Subject: Re: [ACPI] Re: [PATCH] s4bios for 2.5.59 + apci-20030123
Date: Fri, 07 Feb 2003 08:44:08 +1300
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1044560648.1700.17.camel@laptop-linux.cunninghams>
References: <F760B14C9561B941B89469F59BA3A847137FFE@orsmsx401.jf.intel.com>
 <20030204221003.GA250@elf.ucw.cz>
 <1044477704.1648.19.camel@laptop-linux.cunninghams>
 <20030206153757.GB19350@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <20030206153757.GB19350-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2003-02-07 at 04:37, Pavel Machek wrote:

> No, no. It has to be exactly the same kernel, otherwise you get a nice
> crash (if you are lucky) and ugly data corruption (when you are not);
> there's check to prevent that and panic, however.
> 
> That's why I call S4bios more foolproof.

Oh of course; I'm with you. If you're running a different kernel, you
must have had an entirely different context when you suspended. Humble
apologies; I was only thinking about whether the image would
successfully load, not the difference in contents.

Regards,

Nigel
