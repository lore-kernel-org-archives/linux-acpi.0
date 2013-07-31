From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [REGRESSION/PATCH] acpi: blacklist win8 OSI for ASUS Zenbok Prime UX31A
Date: Wed, 31 Jul 2013 06:32:47 -0500
Message-ID: <CAMP44s2B=nQLnZm7gyYAJZgt_x3KszRZLUC=fom0t9=Eze+smA@mail.gmail.com>
References: <1375125658-1223-1-git-send-email-felipe.contreras@gmail.com>
	<3453253.oZLO1ChPbL@vostro.rjw.lan>
	<CAMP44s02V_FO1BPJZqo6MB9RMknXYdV7AXDqbJzYHpgK1GUuJw@mail.gmail.com>
	<37178266.QXgbv9rq0i@vostro.rjw.lan>
	<CAMP44s2LqiEGtS72FuTjsHUa1MH2kfaYHmcpNKMmAm2LnbFCCQ@mail.gmail.com>
	<20130731051421.GA15766@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130731051421.GA15766@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Aaron Lu <aaron.lwe@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jul 31, 2013 at 12:14 AM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Tue, Jul 30, 2013 at 07:11:06PM -0500, Felipe Contreras wrote:
>
>> No, the ACPI driver is exposing a backlight interface, which has a
>> defined stable API.
>
> From the ACPI spec:
>
> 'The OEM may define the number 0 as "Zero brightness" that can mean to
> turn off the lighting (e.g. LCD panel backlight) in the device.'
>
> There's no mechanism for an OS to know whether or not a firmware
> implementation will actually turn the backlight off at 0, so there's no
> way the OS can define the lowest backlight state as anything other than
> "May or may not turn the screen off".

Yes there is; quirks.

-- 
Felipe Contreras
