From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: [PATCH 2/4] toshiba_acpi: Support alternate hotkey interfaces
Date: Mon, 19 Dec 2011 12:24:28 -0600
Message-ID: <20111219182428.GC2737@thinkpad-t410>
References: <1323972371-13189-1-git-send-email-seth.forshee@canonical.com>
 <CAGdLNWFeRD=K0YWwr=r2Rznr1N4B6HMPOUF4vWv1aOZbDy+rEQ@mail.gmail.com>
 <20111217150742.GA6916@ubuntu-mba>
 <201112181501.36299.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:58938 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab1LSSYg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 19 Dec 2011 13:24:36 -0500
Content-Disposition: inline
In-Reply-To: <201112181501.36299.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Azael Avalos <coproscefalo@gmail.com>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Dec 18, 2011 at 03:01:35PM +0100, Thomas Renninger wrote:
> > In the DSDTs I've inspected there is an EC query method that looks like
> > it handles events for the hotkeys, but I've never been able to find
> > anything that will cause the GPE to trigger when the hotkeys are
> > pressed.
> Be careful, those EC event notifications do not show up in:
> /sys/firmware/acpi/interrupts/gpe*
> If no acpi irqs are happening (you said you've tried already):
> watch -n1 "cat /proc/interrupts |grep acpi"
> filtering the key events sounds appropriate.
> I see you dig quite a bit already:

I just went back and tried this specifically again to verify my memory
is correct. Without toshiba_acpi loaded, I see nothing. With it loaded
(with this patch series applied, which turns out to be important) I do
see the interrupt count increase. Further investigation leads me to
conclude that this activity appears to be associated with execution of
the INFO method -- reading and writing a variable in the EC address
space.

Seth
