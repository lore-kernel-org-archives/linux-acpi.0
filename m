From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] ACPI: Implement overriding of arbitrary ACPI tables via initrd
Date: Fri, 23 Mar 2012 21:50:12 -0700
Message-ID: <CAE9FiQXvi-HPO+Ct=k0Ga_uaTrntJW=nh-VKnGbXaovFN=zDaQ@mail.gmail.com>
References: <1332512984-79664-1-git-send-email-trenn@suse.de>
	<201203240242.07724.trenn@suse.de>
	<4F6D2AF8.3070707@zytor.com>
	<201203240402.38749.trenn@suse.de>
	<4F6D50DD.4050306@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51891 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab2CXEuM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Mar 2012 00:50:12 -0400
In-Reply-To: <4F6D50DD.4050306@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Renninger <trenn@suse.de>, eric.piel@tremplin-utc.net, vojcek@tlen.pl, dsdt@gaugusch.at, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Lin Ming <ming.m.lin@intel.com>, lenb@kernel.org, robert.moore@intel.com, Al Viro <viro@zeniv.linux.org.uk>

On Fri, Mar 23, 2012 at 9:43 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> Can this be implemented without using dynamic memory allocations?
>> If not, it's not suitable for early APCI overriding.
>
> Yes it can, as long as it is uncompressed. =A0It just becomes a matte=
r of
> walking the cpio headers which is effectively a linked list.

During checking in reserve_inirtd() (BTW, the name of the function is o=
utdated).
memblock is ready.
So dynamical memory allocation is there already.

also could put that headers in the tail, so old intird utilities could
work as before.

Yinghai
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
