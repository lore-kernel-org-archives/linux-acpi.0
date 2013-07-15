From: Parag Warudkar <parag.lkml@gmail.com>
Subject: Re: BGRT Pointer in System RAM
Date: Mon, 15 Jul 2013 19:56:27 -0400
Message-ID: <CAOULuOY=F5H_=Q1BcbrBxTAj9_9tXvOnm+KAtAksfDw2ei3hVw@mail.gmail.com>
References: <CAOULuOY5VMiiuYmesaGxVWWKtby4Cj9Pc9ctQZeOKfoUzV46dA@mail.gmail.com>
	<CALCETrVk=ovYjHwALtzB3E3nP4TMivhppM42yw7rMRpzA68cbw@mail.gmail.com>
	<20130715230418.GA2649@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:37842 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753834Ab3GOX43 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 15 Jul 2013 19:56:29 -0400
In-Reply-To: <20130715230418.GA2649@leaf>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Andy Lutomirski <luto@amacapital.net>, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Mon, Jul 15, 2013 at 7:04 PM, Josh Triplett <josh@joshtriplett.org> wrote:

> We do need to handle the case of a valid pointer into memory that e820
> calls system RAM, as well as the case of a valid pointer into memory
> reserved for the BIOS or similar, but not the case of an invalid
> pointer.

Would that be as simple as

                     page_is_ram(
