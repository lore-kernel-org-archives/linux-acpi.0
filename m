From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v4 0/2] Correct for ACPI 5.1->6.0 spec changes in MADT
 GICC entries
Date: Tue, 07 Jul 2015 09:07:56 -0600
Message-ID: <559BEB4C.90906@redhat.com>
References: <1436224608-27754-1-git-send-email-al.stone@linaro.org>
 <CAJZ5v0j+iKhOX4hw2XQEdo9CjpP2sfdxGwCz_vN5OVqithEv0Q@mail.gmail.com>
 <20150707133115.GB13228@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150707133115.GB13228@e104818-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Jason Cooper <jason@lakedaemon.net>, Al Stone <al.stone@linaro.org>, "patches@linaro.org" <patches@linaro.org>, Will Deacon <will.deacon@arm.com>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On 07/07/2015 07:31 AM, Catalin Marinas wrote:
> On Tue, Jul 07, 2015 at 01:20:51AM +0200, Rafael J. Wysocki wrote:
>> On Tue, Jul 7, 2015 at 1:16 AM, Al Stone <al.stone@linaro.org> wrote:
>>> In the ACPI 5.1 version of the spec, the struct for the GICC subtable
>>> (struct acpi_madt_generic_interrupt) of the MADT is 76 bytes long; in
>>> ACPI 6.0, the struct is 80 bytes long.  But, there is only one definition
>>> in ACPICA for this struct -- and that is the 6.0 version.  Hence, when
>>> BAD_MADT_ENTRY() compares the struct size to the length in the GICC
>>> subtable, it fails if 5.1 structs are in use, and there are systems in
>>> the wild that have them.
>>>
>>> Note that this was found in linux-next and these patches apply against
>>> that tree and the arm64 kernel tree; 4.1 does not appear to have this
>>> problem since it still has the 5.1 struct definition.
>>>
>>> Though there is precedent in ia64 code for ignoring the changes in size,
>>> this patch set instead verifies correctness.  The first patch adds the
>>> BAD_MADT_GICC_ENTRY() macro to check the GICC subtable only, accounting
>>> for the difference in specification versions that are possible.  The
>>> second patch replaces BAD_MADT_ENTRY usage with the BAD_MADT_GICC_ENTRY
>>> macro in arm64 code, which is currently the only architecture affected.
>>> The BAD_MADT_ENTRY() will continue to work as is for all other MADT
>>> subtables.
>>>
>>> I have tested these patches on an APM Mustang with version 1.15 firmware,
>>> where the problem was found, and they fix the problem -- i.e., the system
>>> will boot with either Linux 4.1 or linux-next kernels using the same ACPI
>>> 5.1 compatible firmware.
>>
>> ACK for the series, but I guess it's better to let it go via ARM64, right?
> 
> Fine by me. I'll pick them up for 4.2-rc2.
> 
> Thanks.
> 

Thanks, Catalin.  Holler if there's any problems.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
