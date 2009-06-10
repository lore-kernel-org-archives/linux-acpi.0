From: Azael Avalos <coproscefalo@gmail.com>
Subject: Re: [PATCH 2/2] toshiba-acpi: Support TOS1900-type devices
Date: Tue, 9 Jun 2009 18:18:59 -0600
Message-ID: <74962ea30906091718o274a0968ica61ee7a8d915ed5@mail.gmail.com>
References: <20090331221107.GA30383@srcf.ucam.org>
	 <20090331230217.GA31599@srcf.ucam.org>
	 <74962ea30904010950u31fbdca3w51eafb9b7ec1ca73@mail.gmail.com>
	 <20090401165345.GA13939@srcf.ucam.org>
	 <74962ea30904011003o354e8780ya5e9ac1a6a579084@mail.gmail.com>
	 <20090401170708.GA14167@srcf.ucam.org>
	 <74962ea30904011013v5ffa0620y1f1aefa2c84e1ce@mail.gmail.com>
	 <20090602140357.GA13548@srcf.ucam.org>
	 <74962ea30906090942r43d374e7ra00e5056eca040a8@mail.gmail.com>
	 <20090609164529.GA11592@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f213.google.com ([209.85.220.213]:51760 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbZFJAS6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jun 2009 20:18:58 -0400
In-Reply-To: <20090609164529.GA11592@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, dsilvers@simtec.co.uk, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org

On Tue, Jun 9, 2009 at 10:45 AM, Matthew Garrett<mjg59@srcf.ucam.org> wrote:

> When you hit a hotkey, what happens in /proc/interrupts? Do you see an
> i8042 event or an acpi event?

Indeed an i8042 event pops up, actually dmesg shows the following
regardless of the hotkey pressed, even by only pressing the Fn key:

atkbd.c: Unknown key released (translated set 2, code 0x6e on isa0060/serio0).
atkbd.c: Use 'setkeycodes 6e <keycode>' to make it known.


Saludos
Azael


-- 
-- El mundo apesta y vosotros apestais tambien --
