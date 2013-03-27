From: Olivier Diotte <olivier@diotte.ca>
Subject: Re: Board hangs without acpi=off
Date: Tue, 26 Mar 2013 20:52:09 -0400
Message-ID: <CAM3Q4oFpdD4irXL05avizCB=Hb8fAzN1HV5QHY1aBBVMDbzNnA@mail.gmail.com>
References: <CAM3Q4oGq+nLYPR68NnA_mTTLvrmRzxWNbRpQ_zjq6VO5_hUp-Q@mail.gmail.com>
	<2284691.bnhzHFpqfq@vostro.rjw.lan>
Reply-To: olivier@diotte.ca
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:61404 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755272Ab3C0AwO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Mar 2013 20:52:14 -0400
Received: by mail-la0-f45.google.com with SMTP id er20so14835512lab.32
        for <linux-acpi@vger.kernel.org>; Tue, 26 Mar 2013 17:52:11 -0700 (PDT)
Received: by mail-la0-f53.google.com with SMTP id fr10so14569580lab.40
        for <linux-acpi@vger.kernel.org>; Tue, 26 Mar 2013 17:52:09 -0700 (PDT)
In-Reply-To: <2284691.bnhzHFpqfq@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org

On Tue, Mar 26, 2013 at 6:47 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, March 26, 2013 11:09:55 AM Olivier Diotte wrote:
> Can you get any debug output from boot attempts without acpi=off?
>
Yes, I did many tests with different values for both parameters. I
took pictures (as logging capacity is somewhat limited though maybe I
could try to test using a serial console) of the last screen of output
for some tests and a few notes (the latter are at work, I'll be able
to send them tomorrow if needed).

By now, the board should be done recompiling Linus' tree, which will
allow me to test with a more recent kernel.

I can post the pictures, but I am unsure what the etiquette is about
that on kernel mailing-lists.

I'll try to transcribe the pictures, the notes and try Linus' kernel
tomorrow when I have access to them all.

Please tell me what would be useful info and I'll happily oblige.

Regards,
Olivier
