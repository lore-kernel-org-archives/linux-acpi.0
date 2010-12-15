From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] - Mapping ACPI tables as CACHED
Date: Tue, 14 Dec 2010 19:04:13 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012141903210.25387@x980>
References: <20101214220932.GA1206@sgi.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:44345 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542Ab0LOAEV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Dec 2010 19:04:21 -0500
In-reply-to: <20101214220932.GA1206@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jack Steiner <steiner@sgi.com>
Cc: hpa@zytor.com, hmh@hmh.eng.br, tony.luck@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gbeshers@sgi.com

hmm, my arrandale laptop fails to get into graphics mode w/ this patch 
applied -- last thing i see is the kernel freeing memory, then black 
screen.

thanks,
Len Brown, Intel Open Source Technology Center

