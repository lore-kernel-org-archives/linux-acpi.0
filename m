From: "Ash Milsted" <thatistosayiseenem@gawab.com>
Subject: Re: 2.6.24-rc1 acpi battery driver -> sysfs interface does not update correctly
Date: Wed, 24 Oct 2007 22:23:20 +0200
Message-ID: <3e7b9f4b0710241323p5bbee5a8r582264d0a2b10f60@mail.gmail.com>
References: <3e7b9f4b0710241114u73ad1d4bl34070b4fd2b18d63@mail.gmail.com>
	 <471F9494.8080503@gmail.com>
	 <3e7b9f4b0710241252y731aec1sd46ca8c36438e9a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wr-out-0506.google.com ([64.233.184.238]:56310 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227AbXJXUXV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Oct 2007 16:23:21 -0400
Received: by wr-out-0506.google.com with SMTP id 36so267221wra
        for <linux-acpi@vger.kernel.org>; Wed, 24 Oct 2007 13:23:20 -0700 (PDT)
In-Reply-To: <3e7b9f4b0710241252y731aec1sd46ca8c36438e9a6@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

On 24/10/2007, Ash Milsted <thatistosayiseenem@gawab.com> wrote:
> On 24/10/2007, Alexey Starikovskiy <aystarik@gmail.com> wrote:
> > Could you please test this patch?
>
> Appears to work again  - sysfs values now seem to update correctly
> without help from a proc read. Will check without ACPI_PROCFS and let
> you know if anything still seems wrong.
>
> Ash
>

Okay, I have a further suspicion that uevents are not being sent as
the battery charge changes. I have HAL 0.5.10 running and it only
updates it's battery status if I (un)plug the power, despite cat
/sys/class/power_supply/BAT1/charge_now now giving a current value.
