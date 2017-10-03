From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [Devel] [PATCH 15/18] acpi: use ARRAY_SIZE
Date: Tue, 3 Oct 2017 13:34:23 +0100
Message-ID: <e0ab5224-1120-4b06-b625-822491d6b926@canonical.com>
References: <20171001193101.8898-1-jeremy.lefaure@lse.epita.fr>
 <1668017.YFhvic4TWu@aspire.rjw.lan>
 <20171002211622.30d324ca@blatinox-laptop.localdomain>
 <5437275.MVdmGJ04h3@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5437275.MVdmGJ04h3@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@lse.epita.fr>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On 03/10/17 12:39, Rafael J. Wysocki wrote:
> On Tuesday, October 3, 2017 3:16:22 AM CEST Jérémy Lefaure wrote:
>> On Mon, 02 Oct 2017 14:27:52 +0200
>> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
>>
>>> ACPICA is soewhat special code, though and I'm not taking or ACKing patches
>>> for it directly as a rule.
>>>
>>> For one, I'm not sure if ACPICA can use ARRAY_SIZE at all.
>> Why is it special code that can't use ARRAY_SIZE ? Is it because this
>> macro is defined in linux/kernel.h ?

However, ACPICA does have ACPI_ARRAY_LENGTH(x), see source/include/actypes.h

> 
> Basically, yes.
> 
> ACPICA is a separate project and the kernel acquires its source code from
> the upstream (which is used by other OSes too).  That is not the case for
> any other code in the kernel I know about.
> 
> 
> We strive to keep the ACPICA code in the kernel as close to the upstream as
> reasonably possible for maintenance reasons, so we avoid doing Linux-specific
> things in it.
> 
> As a rule of thumb, if you do cleanups like this one, better avoid the ACPICA
> code. :-)
> 
> Thanks,
> Rafael
> 
> _______________________________________________
> Devel mailing list
> Devel@acpica.org
> https://lists.acpica.org/mailman/listinfo/devel
> 
