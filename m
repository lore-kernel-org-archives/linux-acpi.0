From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Bogus "APIC: NR_CPUS/possible_cpus limit of 4 reached" messages
Date: Thu, 6 Oct 2016 12:48:00 +0100
Message-ID: <20161006124800.5a824dfc@lxorguk.ukuu.org.uk>
References: <20161006112737.GA308@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:42702 "EHLO
        lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752674AbcJFLsW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Oct 2016 07:48:22 -0400
In-Reply-To: <20161006112737.GA308@x4>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Markus Trippelsdorf <markus@trippelsdorf.de>
Cc: Gu Zheng <guz.fnst@cn.fujitsu.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 6 Oct 2016 13:27:37 +0200
Markus Trippelsdorf <markus@trippelsdorf.de> wrote:

> On current trunk I get during boot:
> 
> [    0.000000] APIC: NR_CPUS/possible_cpus limit of 4 reached.  Processor 4/0x84 ignored.
> [    0.000000] APIC: NR_CPUS/possible_cpus limit of 4 reached.  Processor 5/0x85 ignored.
> 
> I don't think these messages make much sense on a 4-core machine.
> 

Four cores with or without hyperthreading ?

Alan
