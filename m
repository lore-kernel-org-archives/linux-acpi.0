From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] acpi: update win8 OSI blacklist
Date: Sun, 6 Oct 2013 18:36:57 -0500
Message-ID: <CAMP44s1-vCgOkE_h1ZEmCA2WiQyLTOvnis2MOjdu8kdDB39kFg@mail.gmail.com>
References: <1380820383-23336-1-git-send-email-felipe.contreras@gmail.com>
	<20131004161226.GA22784@srcf.ucam.org>
	<CAMP44s0tqKBgUTzFnbTMqDVVWLcaDC5VKd9mq_w+T_Yu19KXqQ@mail.gmail.com>
	<20131006203353.GA19795@srcf.ucam.org>
	<CAMP44s0N5xqD2W7-r-j1k3efo1k0qY2gCeqn+tbHsvOsrqOJgg@mail.gmail.com>
	<20131006204518.GA20077@srcf.ucam.org>
	<CAMP44s0GkVyw+PRYKqq7=MXFFtgUO9xCq6jTsoQV-rSRmC23yg@mail.gmail.com>
	<20131006205928.GA20296@srcf.ucam.org>
	<CAMP44s33CByGsRz7vsNAoOLnbEMY+fz73NzHJq07BzSuCEGJUg@mail.gmail.com>
	<20131006233106.GA21562@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:56029 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab3JFXg6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Oct 2013 19:36:58 -0400
In-Reply-To: <20131006233106.GA21562@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sun, Oct 6, 2013 at 6:31 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> On Sun, Oct 06, 2013 at 06:27:28PM -0500, Felipe Contreras wrote:
>> From acpi_osi_dmi_table:
>>
>> /*
>> * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
>> * Linux ignores it, except for the machines enumerated below.
>> */
>
> Which was a mistake. We learn from mistakes rather than repeating them.

According to you.

Sane human beings have no problem with divisions.

/* section 1 */

a();
b();
c();

/* section 2 */

d();
e();

/* section 3 */

f();

-- 
Felipe Contreras
