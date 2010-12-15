From: Jack Steiner <steiner@sgi.com>
Subject: Re: [PATCH] - Mapping ACPI tables as CACHED
Date: Tue, 14 Dec 2010 20:27:35 -0600
Message-ID: <20101215022735.GA19601@sgi.com>
References: <20101214220932.GA1206@sgi.com> <4D07F6A2.2030706@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from relay1.sgi.com ([192.48.179.29]:36337 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757753Ab0LOC1h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Dec 2010 21:27:37 -0500
Content-Disposition: inline
In-Reply-To: <4D07F6A2.2030706@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: lenb@kernel.org, hmh@hmh.eng.br, tony.luck@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gbeshers@sgi.com

On Tue, Dec 14, 2010 at 02:58:42PM -0800, H. Peter Anvin wrote:
> On 12/14/2010 02:09 PM, Jack Steiner wrote:
> > Map ACPI tables as WB on x86_64. No substantive changes to IA64.
> 
> Why just x86-64?

We never observed a performance problem on IA64. Not sure if it maps
ACPI space as WB or not. Since I did not have easy access to
an ia64, I chose not to make any changes to the way it maps
the table.

