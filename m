From: Janosch Machowinski <scotch@tzi.de>
Subject: Re: Strange interpreter behaviour
Date: Fri, 20 Jan 2006 16:27:50 +0100
Message-ID: <43D10176.302@tzi.de>
References: <43BFF7DE.1000909@tzi.de> <20060116171932.GF25115@poupinou.org> <43CC0FC0.9090806@tzi.de> <20060117103043.GA2154@poupinou.org> <43CCE603.3010600@tzi.de> <20060117132435.GB2154@poupinou.org> <43CCFF1C.4000309@tzi.de> <20060117154742.GD2154@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m1.informatik.uni-bremen.de ([134.102.201.18]:64235 "EHLO
	informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S1750797AbWATP0m (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jan 2006 10:26:42 -0500
In-Reply-To: <20060117154742.GD2154@poupinou.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: linux-acpi@vger.kernel.org

> Sometimes I'm stupid.  Try this version instead.
> 
Okay, this worked,
the outprut from your little programm was 0x500,
but it should be
GPE0_BLK:         0x00000428
GPE1_BLK:         0x00000000

So is this an error in ACPI-CA or in my DSDT ?

