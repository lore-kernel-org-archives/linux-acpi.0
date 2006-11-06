From: Len Brown <len.brown@intel.com>
Subject: Re: SMP C-states on x86_64 Status
Date: Mon, 6 Nov 2006 12:44:55 -0500
Message-ID: <200611061244.56455.len.brown@intel.com>
References: <1162726672.25981.275035845@webmail.messagingengine.com>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:3506 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1753600AbWKFRm1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Nov 2006 12:42:27 -0500
In-Reply-To: <1162726672.25981.275035845@webmail.messagingengine.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathew Brown <mathewbrown@fastmail.fm>
Cc: linux-acpi@vger.kernel.org

On Sunday 05 November 2006 06:37, Mathew Brown wrote:
> Hi,
>   I just saw Adrian's post on a patch to add SMP C-states on x86_64 to
>   kernel 2.6.16.  Is there anywhere I can find the current status of
>   C-states on SMP machines?  I have a 16-core machine running RHEL with
>   kernel 2.6.9-34 and it shows only C0, nothing else.  I checked the
>   DSDT and it compiled without error.  Any ideas?  Thanks for your help.

This support (bugzilla 5653) shipped starting in 2.6.18, and I sent it to Adrian
for 2.6.16.stable -- and it appears it will pop out in 2.6.16.31.

Re: your 16 core machine running 2.6.9...
What does /proc/acpi/processor/*/power say?
I would expect it to say C1 only.

I would not expect this box to grow deeper C-states upon the support above.
The only SMP boxes with C-states deeper than C1 that I'm aware of today
are laptops.

cheers,
-Len



