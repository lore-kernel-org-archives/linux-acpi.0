From: Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: Re: [PATCH 00/25] coresight: Support for ACPI bindings
Date: Fri, 22 Mar 2019 10:13:32 +0000
Message-ID: <80173965-149d-f56e-6b5e-bcf18988e21c@arm.com>
References: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553107783-3340-1-git-send-email-suzuki.poulose@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, coresight@lists.linaro.org, mike.leach@linaro.org, robert.walker@arm.com, rjw@rjwysocki.net
List-Id: linux-acpi@vger.kernel.org

On 03/20/2019 06:49 PM, Suzuki K Poulose wrote:
> This series adds the support for CoreSight devices on ACPI based
> platforms. The device connections are encoded as _DSD graph property[0],
> with CoreSight specific extensions to indicate the direction of data
> flow as described in [1]. Components attached to CPUs are listed
> as child devices of the corresponding CPU, removing explicit links
> to the CPU like we do in the DT.
> 
> As a prepartion for the ACPI support, we merge the driver for dynamic
> and non-programmable replicators. We introduce platform independent
> helpers to parse the platform supplied information. Thus we rename
> the platform handling code from:
> 	of_coresight.c  => coresight-platform.c
> 
> The CoreSight driver creates shadow devices that appear on the Coresight
> bus, in addition to the real devices (e.g, AMBA bus devices). The name
> of these devices match the real device. This makes the device name
> a bit cryptic for ACPI platform. So this series also introduces a generic
> platform agnostic device naming scheme for the shadow Coresight devices.
> Towards this we also make changes to the way we lookup devices to resolve
> the connections, as we can't use the names to identify the devices. So,
> we use the "fwnode_handle" of the real device for the device lookups.
> Towards that we clean up the drivers to keep track of the "CoreSight"
> device rather than the "real" device. However, all real operations,
> like DMA allocation, Power management etc. must be performed on
> the real device which is the parent of the shadow device.
> 
> Finally we add the support for parsing the ACPI platform data. The power
> management support is missing in the ACPI (and this is not specific to
> CoreSight). The firmware must ensure that the respective power domains
> are turned on.
> 
> Applies on v5.1-rc1
> 
> Tested on a Juno-r0 board with ACPI bindings patch (Patch 26/25) added on
> top of [2]. You would need to make sure that the debug power domain is
> turned on before the Linux kernel boots. (e.g, connect the DS-5 to the
> Juno board while at UEFI). arm32 code is only compile tested.
> 
> [0] ACPI Device Graphs using _DSD (Not available online yet, approved but
>      awaiting publish and eventually should be linked at).
>      https://uefi.org/sites/default/files/resources/_DSD-implementation-guide-toplevel-1_1.htm
> [1] https://developer.arm.com/docs/den0067/latest/acpi-for-coresighttm-10-platform-design-document
> [2] https://github.com/tianocore/edk2-platforms.git


The kernel patches are also available here :

git://linux-arm.org/linux-skp.git coresight-acpi/v1

Kind regards
Suzuki
