From: "Sajjan, Vikas C" <vikas.cha.sajjan@hpe.com>
Subject: RE: ARM juno R2 board USB Issue (EHCI probe failed)
Date: Wed, 28 Sep 2016 03:33:32 +0000
Message-ID: <AT5PR84MB0052DB498EA586C6943044F3D9CF0@AT5PR84MB0052.NAMPRD84.PROD.OUTLOOK.COM>
References: <AT5PR84MB005284C92DEA45ADF67A4F55D9CC0@AT5PR84MB0052.NAMPRD84.PROD.OUTLOOK.COM>
 <CAGm_ybhc4DKYkDtE8dVzhC3-kJk138Lbm-zAhepQiyUnuqZQHg@mail.gmail.com>
 <22e151c5-fc83-a48c-b130-f633fac8674f@arm.com>
 <AT5PR84MB00524ACD87B9FF61AAB55223D9CC0@AT5PR84MB0052.NAMPRD84.PROD.OUTLOOK.COM>
 <37a463cb-86d5-e0d7-7e8f-50cec3d65c95@arm.com> <57EA9AAA.5090504@linaro.org>
 <9b231601-2c6a-a5d7-471f-4fc0d8190d83@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <9b231601-2c6a-a5d7-471f-4fc0d8190d83@arm.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Vikas Sajjan <sajjan.linux@gmail.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
List-Id: linux-acpi@vger.kernel.org

Hi All,

-----Original Message-----
From: Robin Murphy [mailto:robin.murphy@arm.com] 
Sent: Tuesday, September 27, 2016 9:53 PM
To: Hanjun Guo <hanjun.guo@linaro.org>; Sudeep Holla <sudeep.holla@arm.com>; Sajjan, Vikas C <vikas.cha.sajjan@hpe.com>; Vikas Sajjan <sajjan.linux@gmail.com>; linux-usb@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-acpi@vger.kernel.org
Cc: mark.rutland@arm.com; lorenzo.pieralisi@arm.com
Subject: Re: ARM juno R2 board USB Issue (EHCI probe failed)

On 27/09/16 17:13, Hanjun Guo wrote:
> On 09/27/2016 05:07 PM, Sudeep Holla wrote:
>>
>>
>> On 27/09/16 09:55, Sajjan, Vikas C wrote:
>>> Hi Sudeep,
>>>
>>> -----Original Message-----
>>> From: Sudeep Holla [mailto:sudeep.holla@arm.com]
>>> Sent: Tuesday, September 27, 2016 2:21 PM
>>> To: Vikas Sajjan <sajjan.linux@gmail.com>; 
>>> linux-usb@vger.kernel.org; linux-arm-kernel@lists.infradead.org; 
>>> linux-acpi@vger.kernel.org
>>> Cc: Sudeep Holla <sudeep.holla@arm.com>; mark.rutland@arm.com; 
>>> lorenzo.pieralisi@arm.com; Sajjan, Vikas C 
>>> <vikas.cha.sajjan@hpe.com>
>>> Subject: Re: ARM juno R2 board USB Issue (EHCI probe failed)
>>>
>>> Hi Vikas,
>>>
>>> On 27/09/16 09:14, Vikas Sajjan wrote:
>>>> Adding USB mailing list.
>>>>
>>>>
>>>> On Tue, Sep 27, 2016 at 12:33 PM, Sajjan, Vikas C 
>>>> <vikas.cha.sajjan@hpe.com> wrote:
>>>>> Hi All,
>>>>>
>>>>> I working on ARM juno R2 board, with latest kernel 4.8.rc7 and I 
>>>>> get below USB EHCI probe error while booting with acpi=force.
>>>>>
>>>
>>> Are you using the latest UEFI EDK2 ?
>>> No, I am still using the UEFI binary which came as part of the Juno 
>>> board.
>>>
>>>
>>>>> [    1.223662] VFIO - User Level meta-driver version: 0.3
>>>>> [    1.229335] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI)
>>>>> Driver
>>>>> [    1.235882] ehci-pci: EHCI PCI platform driver
>>>>> [    1.240359] ehci-platform: EHCI generic platform driver
>>>>> [    1.245619] ehci-platform ARMH0D20:00: Error: DMA mask
>>>>> configuration failed
>>>>> [    1.272491] ehci-platform: probe of ARMH0D20:00 failed with
>>>>> error -5
>>>>> [    1.278876] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
>>>>> [    1.285071] ohci-pci: OHCI PCI platform driver
>>>>> [    1.289548] ohci-platform: OHCI generic platform driver
>>>>> [    1.294884] usbcore: registered new interface driver usb-storage
>>>>> [    1.301231] mousedev: PS/2 mouse device common for all mice
>>>>> [    1.307197] rtc-efi rtc-efi: rtc core: registered rtc-efi as rtc0
>>>>>
>>>>> But this error goes off, if I don't force ACPI booting, i.e., if I 
>>>>> remove acpi=force from kernel command line , USB is detected  and 
>>>>> my RFS which is in the usb drive, gets mounted successfully.
>>>>>
>>>
>>> As I mentioned in private, I do get the same error if I drop _CCA in 
>>> USB object of ACPI DSDT. Can you give it a spin with latest UEFI ?
>>>
>>> Sure, will try with latest UEFI.
>>>
>>
>> I bet that's 8-12 months old. It puts the banner during boot with the 
>> build date. You can try to follow [1] or access it from [2]
> 
> Agree.
> 
> D03 is using the same IP (EHCI) and the USB works fine with _CCA in 
> the device node.

_CCA is mandatory on arm64 (see CONFIG_ACPI_CCA_REQUIRED). Any devices without it are going to end up with the dummy DMA ops which intentionally fail if a driver tries to use them - i.e. the error seen above is by design.

Thank you for the clarification.

Thanks and Regards
Vikas Sajjan

Robin.

> 
> Thanks
> Hanjun
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
