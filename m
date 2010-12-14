From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] - Mapping ACPI tables as CACHED
Date: Tue, 14 Dec 2010 14:58:42 -0800
Message-ID: <4D07F6A2.2030706@zytor.com>
References: <20101214220932.GA1206@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:48059 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756473Ab0LNW6y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Dec 2010 17:58:54 -0500
In-Reply-To: <20101214220932.GA1206@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jack Steiner <steiner@sgi.com>
Cc: lenb@kernel.org, hmh@hmh.eng.br, tony.luck@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gbeshers@sgi.com

On 12/14/2010 02:09 PM, Jack Steiner wrote:
> Map ACPI tables as WB on x86_64. No substantive changes to IA64.

Why just x86-64?

	-hpa
