From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] X86: Solve Dell Latitudes do not reboot on x86_64 more generally
Date: Mon, 7 Nov 2011 12:40:53 -0500
Message-ID: <CAJvTdK=epzoNO5ObzJgcY1vL9QXeRPiD1yzC3zBzdbAmCradww@mail.gmail.com>
References: <4EB39139.3090709@suse.de>
	<201111071525.14255.trenn@suse.de>
	<20111107142740.GA17686@srcf.ucam.org>
	<201111071609.54731.trenn@suse.de>
	<20111107151213.GA20270@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:32795 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932685Ab1KGRkz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Nov 2011 12:40:55 -0500
In-Reply-To: <20111107151213.GA20270@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Renninger <trenn@suse.de>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, stable@kernel.org

The SMM bugs relating to CPU0 pre-date the existence of VT-D

It is the same old story...
Linux is on thin-ice exercising FW that has been validated only
under (some version of) Windows.
-- 
Len Brown, Intel Open Source Technology Center
