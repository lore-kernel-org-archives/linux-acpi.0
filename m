From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] - Mapping ACPI tables as CACHED
Date: Tue, 14 Dec 2010 20:17:04 -0800
Message-ID: <4D084140.1070700@zytor.com>
References: <20101214220932.GA1206@sgi.com> <4D07F6A2.2030706@zytor.com> <20101215022735.GA19601@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:45695 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759274Ab0LOERm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Dec 2010 23:17:42 -0500
In-Reply-To: <20101215022735.GA19601@sgi.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jack Steiner <steiner@sgi.com>
Cc: lenb@kernel.org, hmh@hmh.eng.br, tony.luck@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, gbeshers@sgi.com

On 12/14/2010 06:27 PM, Jack Steiner wrote:
> On Tue, Dec 14, 2010 at 02:58:42PM -0800, H. Peter Anvin wrote:
>> On 12/14/2010 02:09 PM, Jack Steiner wrote:
>>> Map ACPI tables as WB on x86_64. No substantive changes to IA64.
>>
>> Why just x86-64?
> 
> We never observed a performance problem on IA64. Not sure if it maps
> ACPI space as WB or not. Since I did not have easy access to
> an ia64, I chose not to make any changes to the way it maps
> the table.
> 

You're missing the point: x86-64 as opposed to x86 in general.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

