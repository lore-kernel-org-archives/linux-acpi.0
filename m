From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC  - V2] - Mapping ACPI tables as CACHED
Date: Wed, 08 Dec 2010 17:27:39 -0800
Message-ID: <4D00308B.2040009@zytor.com>
References: <20100722152220.GA18290@sgi.com> <20100724001449.GA9618@khazad-dum.debian.net> <4C743C0F.2010101@zytor.com> <20100826171704.GA21584@sgi.com> <4C76AD82.2030105@zytor.com> <20101208212244.GA24280@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:49266 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375Ab0LIB3Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Dec 2010 20:29:16 -0500
In-Reply-To: <20101208212244.GA24280@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jack Steiner <steiner@sgi.com>
Cc: lenb@kernel.org, hmh@hmh.eng.br, mingo@elte.hu, tglx@linutronix.de, tony.luck@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gbeshers@sgi.com

On 12/08/2010 01:22 PM, Jack Steiner wrote:
> 
> This patch substantially reduces the time to run ACPIDUMP on a large system:
>  	527 seconds without the patch
>  	  8 seconds with the patch
> 

This is probably the worst possible motivation you can give here.
Bootup time is much more of an issue.

However, this really needs Len's ack.

	-hpa
