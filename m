From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] Convert width in bits to bytes in __acpi_ioremap_fast()
Date: Tue, 25 Oct 2011 13:34:51 -0600
Message-ID: <CAErSpo5TNKy0woVQFFRW7oFMdNNBu4Jf9w8VwC4FTW-48e=GwA@mail.gmail.com>
References: <4ea1e75f5296b6c6b@agluck-desktop.sc.intel.com>
 <4EA62396.2070002@intel.com> <CAErSpo5cW14d5BM7_XJiL1o2ryamWUO3_uz5LBiyooApdbizQg@mail.gmail.com>
 <987664A83D2D224EAE907B061CE93D5301F1F36568@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:38246 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab1JYTfN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 25 Oct 2011 15:35:13 -0400
Received: from hpaq1.eem.corp.google.com (hpaq1.eem.corp.google.com [172.25.149.1])
	by smtp-out.google.com with ESMTP id p9PJZCAb011190
	for <linux-acpi@vger.kernel.org>; Tue, 25 Oct 2011 12:35:13 -0700
Received: from ggnk3 (ggnk3.prod.google.com [10.218.97.67])
	by hpaq1.eem.corp.google.com with ESMTP id p9PJTwRY011279
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Tue, 25 Oct 2011 12:35:11 -0700
Received: by ggnk3 with SMTP id k3so1208474ggn.1
        for <linux-acpi@vger.kernel.org>; Tue, 25 Oct 2011 12:35:11 -0700 (PDT)
In-Reply-To: <987664A83D2D224EAE907B061CE93D5301F1F36568@orsmsx505.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Myron Stowe <mstowe@redhat.com>

[+cc Myron]

On Tue, Oct 25, 2011 at 12:39 PM, Luck, Tony <tony.luck@intel.com> wrot=
e:
>> Myron posted a nice patch recently to remove atomicio.c altogether:
>> http://marc.info/?l=3Dlinux-acpi&m=3D131733358818849&w=3D2
>>
>> I haven't seen any response to it, but I think it's a nice approach
>> and it gets rid of all this special-case pre-map, post-unmap, atomic
>> read/write stuff.
>
> Does that meet the needs of the:
>
> =A0panic in NMI/machine check context
> =A0 =A0kmsg_dump
> =A0 =A0 =A0pstore
> =A0 =A0 =A0 =A0ERST
> =A0 =A0 =A0 =A0 =A0acpi reads & writes
>
> call chain? =A0I thought that atomicio was created for paths where th=
e normal
> acpi operations had problems in NMI contexts.

Yes, it should meet those needs.  The reason we couldn't use
acpi_read() in NMI contexts was that it did an ioremap(), which may
need to allocate memory.  Therefore, we added acpi_pre_map_gar(),
which did the ioremap() early, in process context, and
acpi_atomic_read(), which relies on that mapping to perform the
access.

Myron's work adds acpi_os_map_generic_address(), which is basically
the same as acpi_pre_map_gar().  You call this in process context, and
it does the ioremap() and saves the resulting mapping.  Then he
changed acpi_os_read_memory() (the guts of acpi_read()) so it only
does the ioremap() if there's no existing mapping.

The net result is that acpi_read() should now be safe in NMI context,
as long as you are reading things you've previously mapped with
acpi_os_map_generic_address().

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
