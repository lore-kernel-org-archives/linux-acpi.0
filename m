From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Subject: Re: EHCI_HCD resets cause USB disks to fail - caused by CPU C-states.
Date: Fri, 18 Sep 2009 14:46:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0909181443300.3123-100000@iolanthe.rowland.org>
References: <4AB3C97C.8090209@jan-holst.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4AB3C97C.8090209-U6CCXNQo4XNlY7y4Fx5NiA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jan Holst Jensen <jan-U6CCXNQo4XNlY7y4Fx5NiA@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux-pm mailing list <linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

[Adding CC's, since this is a CPU power management issue just as much 
as a USB issue.]

On Fri, 18 Sep 2009, Jan Holst Jensen wrote:

> Hi.
> 
> I recently had severe problems with a new PC. When attaching an external 
> USB disk I would see USB resets once in a while in /var/log/messages and 
> after another while the disk would disconnect and data would be lost. 
> Like this
> 
> Sep 13 13:30:56 rumleskaft kernel: [164642.760290] usb 1-5: reset high 
> speed USB device using ehci_hcd and address 3
> [repeated a number of times]
> Sep 13 13:31:17 rumleskaft kernel: [164663.430421] sd 2:0:0:0: Device 
> offlined - not ready after error recovery
> Sep 13 13:31:17 rumleskaft kernel: [164663.430459] sd 2:0:0:0: [sdb] 
> Result: hostbyte=DID_ABORT driverbyte=DRIVER_OK,SUGGEST_OK
> Sep 13 13:31:17 rumleskaft kernel: [164663.436193] usb 1-5: USB 
> disconnect, address 3
> Sep 13 13:31:17 rumleskaft kernel: [164663.436446] sd 2:0:0:0: [sdb] 
> Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK,SUGGEST_OK
> Sep 13 13:31:17 rumleskaft kernel: [164663.437711] lost page write due 
> to I/O error on sdb2
> Sep 13 13:31:17 rumleskaft kernel: [164663.454184] lost page write due 
> to I/O error on sdb2
> 
> On my machine I found that disabling CPU C-states and forcing "GV3 only" 
> solved the problem completely. So in some cases it would seem that CPU 
> power management is causing timing issues (?). Can this be fixed in the 
> USB driver layer or does it take cooperation from the kernel's CPU power 
> management - or perhaps a combination of both ?
> 
> You can read more details about my issue at
> 
> http://www.fit-pc2.com/forum/viewtopic.php?f=26&t=851
> 
> Cheers
> -- Jan Holst Jensen, Denmark

For what it's worth, I haven't heard of anything like this before and I
have no idea what the answers are.  My guess is that a hardware bug is
responsible for the misbehavior while in higher C states.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
