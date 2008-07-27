From: Jeff Trull <linmodemstudent@gmail.com>
Subject: Re: no self-refresh during S3 - any debug hints?
Date: Sun, 27 Jul 2008 13:22:53 -0700
Message-ID: <200807271322.53904.linmodemstudent@gmail.com>
References: <685450530805311215lf463875g8eed40da630b4f96@mail.gmail.com> <20080619150947.GA19908@srcf.ucam.org> <685450530806190940g7bd9edb9q3d98050755aee345@mail.gmail.com>
Reply-To: linmodemstudent@gmail.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.179]:58708 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757740AbYG0UXu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Jul 2008 16:23:50 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2762463waf.23
        for <linux-acpi@vger.kernel.org>; Sun, 27 Jul 2008 13:23:50 -0700 (PDT)
In-Reply-To: <685450530806190940g7bd9edb9q3d98050755aee345@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

Hi Matthew,

Did this data provide any insights?

If it seems like a hopeless case that's all right, I guess - I've moved on to 
a laptop with fully-supported hardware (courtesy Zareason) but if there's any 
chance of finding root cause I'll keep the old one for testing potential 
patches, etc.

Thanks and Regards,
Jeff Trull

On Thursday 19 June 2008 09:40:30 Jeff Trull wrote:
> Delighted to!
>
> On Thu, Jun 19, 2008 at 8:09 AM, Matthew Garrett <mjg59@srcf.ucam.org> 
wrote:
> > On Sat, May 31, 2008 at 12:15:50PM -0700, Jeff Trull wrote:
> >> I'm running kernel 2.6.20 on a laptop with an ATI IGP 320M Northbridge
> >> and an Athlon XP.  DSDT has a _PTS but no _GTS.  I'm comfortable
> >> recompiling the kernel.  Any suggestions as to how to proceed,
> >> experiments to run, etc.?
> >
> > Hi Jeff,
> >
> > Could you attach the output of lspci -vxxx -s 0:0.0 ? Needs to be run as
> > root.
> >
> > --
> > Matthew Garrett | mjg59@srcf.ucam.org
