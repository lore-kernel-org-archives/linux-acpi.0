From: glen martin <lists@locutory.org>
Subject: Re: no /proc/acpi, trying to dump dsdt to a file
Date: Wed, 29 Mar 2006 13:15:26 -0800
Message-ID: <442AF8EE.2040000@locutory.org>
References: <971FCB6690CD0E4898387DBF7552B90E04D4B597@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from m198-163.dsl.rawbw.com ([198.144.198.163]:27120 "EHLO
	slowpoke.locutory.org") by vger.kernel.org with ESMTP
	id S1750980AbWC2VPZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Mar 2006 16:15:25 -0500
In-Reply-To: <971FCB6690CD0E4898387DBF7552B90E04D4B597@orsmsx403.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

The first two did look like a bad name .. certainly removing the Ctrl-C
character from the middle of the name cleared the error. I haven't made
further headway ... maybe I'll take a stab at the extern.

I still wonder why the compiler was segfaulting on the file from the
repository, instead of my own disassembled one. I've been wandering
through the diff between mine and the repository to see what differences
there are ... and there are a number, but I can't say I understand this
language well enough to know what they're all for.

glen


