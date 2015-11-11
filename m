From: Dmitry Krivenok <krivenok.dmitry@gmail.com>
Subject: Re: [PATCH 3/4] nvdimm: Add IOCTL pass thru
Date: Thu, 12 Nov 2015 00:52:47 +0300
Message-ID: <CAJN_NGZufvD=GLkw2sscCOEdY9JB0ADSQzggrnEeeEGtdZkiOQ@mail.gmail.com>
References: <CAJN_NGaPbziX=OcyYpcn5TP76HwGQSTsUz-yOVGB2Sh8VxDQjA@mail.gmail.com>
	<20151109215904.GB33245@tevye.fc.hp.com>
	<CAJN_NGY0Zop4=_NrW8Y3md7Up9FRq9voQ2UYiTPgXCv9XP8u5A@mail.gmail.com>
	<20151111214435.GB95024@tevye.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36166 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbbKKVws (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Nov 2015 16:52:48 -0500
In-Reply-To: <20151111214435.GB95024@tevye.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jerry Hoemann <Jerry.Hoemann@hpe.com>
Cc: ross.zwisler@linux.intel.com, rjw@rjwysocki.net, Len Brown <lenb@kernel.org>, dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org

> but, we still want to go through entire list.

Shouldn't you break the loop immediately after you found the bus and sent ioctl?
Maybe I'm missing something, but I see no reason to continue iterating
after the bus was found (even though you don't do anything and just
compare IDs and "continue").
