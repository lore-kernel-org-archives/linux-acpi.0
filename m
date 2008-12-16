From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend/resume fails on second attempt in LNXVIDEO:00
Date: Tue, 16 Dec 2008 16:25:37 +0100
Message-ID: <200812161625.37318.rjw@sisk.pl>
References: <gi247o$iog$1@ger.gmane.org> <200812160002.43427.rjw@sisk.pl> <gi7433$m5f$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758604AbYLPPZ4@vger.kernel.org>
In-Reply-To: <gi7433$m5f$1@ger.gmane.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tuesday, 16 of December 2008, Brian J. Murrell wrote:
> On Tue, 16 Dec 2008 00:02:43 +0100, Rafael J. Wysocki wrote:
> > 
> > No, most probably your graphics adapter is not handled correctly in this
> > case, because it needs some special user space quirks, which are done by
> > hald that is not running.
> 
> Hrm.  OK.
>  
> > You can try to use the s2ram binary (http://en.opensuse.org/s2ram) to
> > work around this issue.
> 
> That sounds like I am setting for something less than optimal.  Is that 
> the case?  Why would I want to use what I've been trying to get working 
> rather than s2ram?  Maybe put another way, why isn't everyone using s2ram?

Because the hal-driven whitelist allows us to match systems in a more detailed
way.  If your system is in the s2ram whitelist already and works with it, there
shouldn't be any difference.

Still, I was only considering that as a debugging aid in your case, because
s2ram works in the minimal configuration, while hald doesn't.

> Ultimately I'm going to want to be able to suspend as well as hibernate, 
> for whatever that's worth.
> 
> > Anyway, if you suspend for the second time from this state, does it
> > resume?
> 
> No.  It fails just as miserably.  :-(

That's a bit of new information.

What's the list of modules loaded in the minimal configuration?

Rafael
