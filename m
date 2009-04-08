From: Alexey Klimov <klimov.linux@gmail.com>
Subject: Re: commit "ACPI: battery: asynchronous init" brokes my boot up
	process
Date: Wed, 8 Apr 2009 15:06:28 +0400
Message-ID: <208cbae30904080406j69afbc8dg1d9011359dbdb396@mail.gmail.com>
References: <208cbae30904080338x749800b0o392886ab023018b6@mail.gmail.com>
	 <5a4c581d0904080351m6811ab81i59c9bc1043071d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:51037 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbZDHLGa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Apr 2009 07:06:30 -0400
In-Reply-To: <5a4c581d0904080351m6811ab81i59c9bc1043071d3@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org, len.brown@intel.com, linux-acpi@vger.kernel.org

On Wed, Apr 8, 2009 at 2:51 PM, Alessandro Suardi
<alessandro.suardi@gmail.com> wrote:
> On Wed, Apr 8, 2009 at 12:38 PM, Alexey Klimov <klimov.linux@gmail.co=
m> wrote:
>> Hello,
>>
>> I don't know if i do right thing creating this letter but looks like
>> this commit 0f66af530116e9f4dd97f328d91718b56a6fc5a4 "ACPI: battery:
>> asynchronous init" brokes my boot up process. My machine is pentium-=
m
>> cpu, Gentoo, gcc 4.3.3-r2.
>
> Vegard Nossum posted a patch that fixes this problem, it's
> =A0currently applied in Len Brown's tree so it should soon
> =A0appear in the mainline kernel:
>
> http://lkml.indiana.edu/hypermail/linux/kernel/0904.0/03127.html

Oh, i applied this patch and it works fine.
Thanks for letting me know :)

--=20
Best regards, Klimov Alexey
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
