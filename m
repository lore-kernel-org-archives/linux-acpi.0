From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] eeepc-laptop: Use standard interfaces
Date: Tue, 19 Aug 2008 02:58:15 -0700
Message-ID: <20080819025815.b5ec1a4c.akpm@linux-foundation.org>
References: <20080804170833.GA9513@srcf.ucam.org>
	<20080806092352.GA17801@srcf.ucam.org>
	<20080806092523.GB17801@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46170 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753110AbYHSJ7E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Aug 2008 05:59:04 -0400
In-Reply-To: <20080806092523.GB17801@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: corentincj@iksaif.net, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, 6 Aug 2008 10:25:23 +0100 Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> eeepc-laptop currently only sends key events via ACPI and has 
> non-standard rfkill control. Add an input device and use the rfkill 
> infrastructure.
>

drivers/misc/eeepc-laptop.c: In function 'eeepc_hotk_add':
drivers/misc/eeepc-laptop.c:577: error: 'CM_ASL_WIFI' undeclared (first use in this function)
drivers/misc/eeepc-laptop.c:577: error: (Each undeclared identifier is reported only once
drivers/misc/eeepc-laptop.c:577: error: for each function it appears in.)
drivers/misc/eeepc-laptop.c:595: error: 'eeepc_bluetooth_rfkill_set' undeclared (first use in this function)
drivers/misc/eeepc-laptop.c:597: error: 'eeepc_bluetooth_rfkill_state' undeclared (first use in this function)

maybe this had some dependencies which I didn't know about.

