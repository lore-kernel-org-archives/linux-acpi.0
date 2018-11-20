From: "Alex G." <mr.nuke.me@gmail.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Tue, 20 Nov 2018 16:35:34 -0600
Message-ID: <ea1048ed-7e9c-4ab5-4a05-01cbddae5c19@gmail.com>
References: <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
 <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
 <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
 <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
 <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
 <20181120214243.GG26707@localhost.localdomain>
 <bace940c-70d9-6631-9818-43338d194327@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bace940c-70d9-6631-9818-43338d194327@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>, Keith Busch <keith.busch@intel.com>
Cc: Alex_Gagniuc@Dellteam.com, baicar.tyler@gmail.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org



On 11/20/2018 04:28 PM, Sinan Kaya wrote:
> On 11/20/2018 4:42 PM, Keith Busch wrote:
>> How does that work? If the OS takes control, it sets up MSIs that FW 
>> don't
>> react to, and disables system errors through PCIe Root Control. Aren't
>> those sys errs the mechanism FW knows it has something to do, which
>> means the OS can effectively fence it off?
> 
> I think this is all implementation detail and doesn't necessarily apply
> to all firmware-first implementation flavors.
> 
> Assumptions are:
> 1. both FW and OS are listening to MSI interrupts

On hax86, I'm not sure FW can listen to MSI interrups. FW only exists in 
SMM, not ring 1-4.

> 2. FW monitors the system errors
> 
> Some FF implementation could route the AER interrupt to a higher privilege
> level. Some other implementation could use INTx or a side-band channel 
> interrupt
> for firmware-interrupt too.
> 
> I have seen all 3 except MSI :) and also firmware never monitored the 
> system
> error bits. I was curious if anybody ever used those legacy bits. Now, I 
> know
> someone is using it.
