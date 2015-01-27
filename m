From: Antonio Ospite <ao2@ao2.it>
Subject: Re: Overriding DSDT and ignored resources
Date: Tue, 27 Jan 2015 15:39:15 +0100
Message-ID: <20150127153915.6eae00cb734ca25ce3e7a107@ao2.it>
References: <20150122145729.281f038e8326019a50612e37@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp208.alice.it ([82.57.200.104]:54981 "EHLO smtp208.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752207AbbA0OjU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Jan 2015 09:39:20 -0500
Received: from jcn (79.2.138.31) by smtp208.alice.it (8.6.060.28)
        id 547D8C0408A9B516 for linux-acpi@vger.kernel.org; Tue, 27 Jan 2015 15:39:16 +0100
In-Reply-To: <20150122145729.281f038e8326019a50612e37@ao2.it>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

On Thu, 22 Jan 2015 14:57:29 +0100
Antonio Ospite <ao2@ao2.it> wrote:

> Hi,
> 
> it looks like linux can't use the correct PCI host resources when using
> an overridden DSDT table, even with an _unmodified_ one.
> 
> I am using 3.19-rc5 rather vanilla (no acpi changes anyways) on a Bay
> Trail tablet.
> 

Issue still there in 3.19-rc6.
Does anyone have a clue of what is going on?

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
