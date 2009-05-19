From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] Explicitly disable BT radio using rfkill interface on suspend
Date: Tue, 19 May 2009 21:58:11 +0200
Message-ID: <200905192158.12784.oliver@neukum.org>
References: <4A11C126.1000704@dell.com> <20090519163333.GA17189@srcf.ucam.org> <4A12E3DF.3070402@dell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:56829 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751113AbZEST5y (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2009 15:57:54 -0400
In-Reply-To: <4A12E3DF.3070402@dell.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Marcel Holtmann <marcel@holtmann.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Am Dienstag, 19. Mai 2009 18:52:47 schrieb Mario Limonciello:
> Hi Matthew:
>
> Matthew Garrett wrote:
> > On Tue, May 19, 2009 at 11:30:32AM -0500, Mario Limonciello wrote:
> >
> >
> > I thought all USB devices got reenumerated on resume?
>
> Leaving udevadm monitor running on a terminal during S3, I don't see any
> events that would agree with this.

If the drivers support reset_resume(), no udev event is generated, but the
devices have to be present for that. Please post dmesg.

	Regards
		Oliver

