Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A100A41A761;
	Tue, 28 Jul 2026 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785228824; cv=none; b=HXXnIOIoEBlvh+IwZNDL2HuHDelQdTBZQYux3/YYfM658xY+le5s3kQuFh85UXxdFjczjaK+s3Z0+lsWmeALLQjKx62+xk1+aI9YGqBV9XrkWhTk763vDxlOrtfTeZCmEHhMBdqvzfbTUy0y9++Sy9oFwzVCCeBPNz73w7yarWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785228824; c=relaxed/simple;
	bh=q2hbfGbQHaY6rPWZE8E4hYxoeFyerkZxkVa21PalgWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCmAJ10wQic5SjJ7ymoJTtx5Po27TOuaMfoevBLht12GBwwsaDcFLBnJOeaCxHzMH6jF0pZt/Ub352cEbJNzrTvt3BLDK21phFk2ntSAYjcq9lfj9kJrSNeyh03h+60PIfFWLKU8vio3Wz3RBxvyO7GLzTHBFMw3XbM8OCO0I6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdSe6iFX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdSe6iFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911061F01558;
	Tue, 28 Jul 2026 08:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785228822;
	bh=H7fev+SkGyN9dwqneF8wGz0L9AJDYK9rgIHDzaAUb9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GdSe6iFXFbfiWRcgQvA4B2opSX9qDpHH/VMDrwDe7eL5CPuZWLqrN40c0jRqnXjvr
	 Rkdm10UTOg8GXwcjtBmw1JscwG7flZWeT3OBjaRCqogbycJDEllKyJILE5kixtf4Vl
	 Ghe+v6C36cWsqIFJ9CXvkMAN936xkGC+oUeJjnnH5dMukY7jmkqaBq5fk+S7P1ii0F
	 +LDRotUSrAW3G0UsbQQUHU8BaUFOVeQ+pKgIAX5H7viSHjfsr/6DqJ9Gm4g3ddSfNs
	 aJTjVI/DtySleeNZTf5RkbPNFY2Fv0ZhpVPHpnsZCLJR5evSr+/0VC4sOuSyxTUpM2
	 7ykU+e0uJzdyQ==
Date: Tue, 28 Jul 2026 10:53:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Ruidong Tian <tianruidong@linux.alibaba.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org, 
	faruque.ansari@oss.qualcomm.com, avaneesh.dwivedi@oss.qualcomm.com
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: ras: Introduce bindings for ARM
 RAS error sources
Message-ID: <20260728-fervent-optimal-auk-7850ae@quoll>
References: <20260720081954.1858180-1-umang.chheda@oss.qualcomm.com>
 <20260720081954.1858180-2-umang.chheda@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260720081954.1858180-2-umang.chheda@oss.qualcomm.com>

On Mon, Jul 20, 2026 at 01:49:51PM +0530, Umang Chheda wrote:
> ARMv8 and later processors implement the RAS (Reliability,
> Availability and Serviceability) extensions, exposing hardware
> error records through a standardised register interface.
>=20
> Add Device Tree bindings to describe RAS error sources.
>=20
> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>

A nit, subject: drop second/last, redundant "bindings for". The
"dt-bindings" prefix is already stating that these are bindings.
See also:
https://elixir.bootlin.com/linux/v7.1-rc7/source/Documentation/devicetree/b=
indings/submitting-patches.rst#L23

> ---
>  .../bindings/arm/arm,ras-error-source.yaml    | 330 ++++++++++++++++++
>  include/dt-bindings/arm/arm-ras.h             |  11 +
>  2 files changed, 341 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,ras-error-s=
ource.yaml
>  create mode 100644 include/dt-bindings/arm/arm-ras.h
>=20
> diff --git a/Documentation/devicetree/bindings/arm/arm,ras-error-source.y=
aml b/Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml
> new file mode 100644
> index 000000000000..add7063a1a62
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml

Filename should resemble compatible, so "arm,ras.yaml"

> @@ -0,0 +1,330 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/arm,ras-error-source.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM RAS error source
> +
> +maintainers:
> +  - Umang Chheda <umang.chheda@oss.qualcomm.com>
> +
> +description: |
> +  ARMv8 and later processors implement the Reliability, Availability and
> +  Serviceability (RAS) extensions.  Hardware blocks that support RAS exp=
ose
> +  one or more error records through a standardised register interface.  =
Each
> +  error record captures information about a detected hardware error (cac=
he
> +  ECC fault, TLB parity error, interconnect error, etc.) and can optiona=
lly
> +  signal the OS via an interrupt.
> +
> +  Each DT node described by this binding represents one RAS error source=
 =E2=80=94
> +  a hardware block that exposes a set of error records.  Error records a=
re
> +  accessed either through system registers (for processor-local resources
> +  such as L1/L2 caches and TLBs) or through a memory-mapped register win=
dow
> +  (for shared or off-core resources such as L3 caches, SMMUs and GICs).
> +
> +properties:
> +  compatible:
> +    description:
> +      Identifies the class of hardware block this error source belongs t=
o.
> +      arm,ras-processor covers processor error sources (cache, TLB, etc.=
).
> +      arm,ras-smmu covers SMMU error sources.
> +      arm,ras-gic covers GIC error sources.
> +    enum:
> +      - arm,ras-processor
> +      - arm,ras-smmu
> +      - arm,ras-gic
> +
> +  reg:
> +    description:
> +      Register windows for this error source.  When absent the error rec=
ords
> +      are accessed through system registers (ERRSELR_EL1 + ERX*_EL1).
> +      When present, the first range is the primary error-record window;
> +      additional named ranges are identified by reg-names.
> +    minItems: 1
> +    maxItems: 4
> +
> +  reg-names:
> +    description:
> +      Names for the optional additional register windows beyond the prim=
ary
> +      error-record window.  err-group is the error group status register
> +      window (ERRGSR).  fault-inject is the fault injection register win=
dow
> +      (ERXPFG*).  irq-config is the interrupt routing configuration wind=
ow.
> +    minItems: 1
> +    maxItems: 3
> +    items:
> +      enum:
> +        - err-group
> +        - fault-inject
> +        - irq-config
> +
> +  interrupts:
> +    description:
> +      Interrupts signalled by this error source.  The first interrupt is=
 the
> +      Fault Handling Interrupt (FHI), fired when a corrected error count=
er
> +      overflows or a deferred error is detected.  The optional second
> +      interrupt is the Error Recovery Interrupt (ERI), fired when an
> +      uncorrected recoverable error is detected.
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupt-names:
> +    description:
> +      Names identifying the interrupts.  "fhi" is the Fault Handling
> +      Interrupt; "eri" is the optional Error Recovery Interrupt.
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      enum:
> +        - fhi
> +        - eri
> +
> +  arm,group-format:
> +    description:
> +      Page granularity of the memory-mapped error record group register
> +      window.  Determines the ioremap size and the number of error group
> +      status registers (ERRGSR) available.  Required when reg is present.
> +      Use the ARM_RAS_GROUP_* constants from <dt-bindings/arm/arm-ras.h>.
> +      0 (ARM_RAS_GROUP_4K) is a 4 KiB window with 1 ERRGSR supporting up
> +      to 64 records.  1 (ARM_RAS_GROUP_16K) is 16 KiB with 4 ERRGSRs and
> +      up to 256 records.  2 (ARM_RAS_GROUP_64K) is 64 KiB with 14 ERRGSRs
> +      and up to 896 records.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]
> +
> +  arm,num-records:
> +    description:
> +      Total number of error records in this error source, including both
> +      implemented and unimplemented slots.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 1
> +
> +  arm,record-impl:
> +    description:
> +      Bitmap of implemented error records.  Bit N set to 1 means error
> +      record N is present and active in this error source.  Bit N set to=
 0
> +      means record N is not implemented and must be skipped.  The array
> +      length must equal the number of ERRGSRs implied by arm,group-format
> +      (1 element for 4K, 4 for 16K, 14 for 64K).  For system-register
> +      nodes (no reg property) a single u64 element is used.
> +    $ref: /schemas/types.yaml#/definitions/uint64-array
> +    minItems: 1
> +    maxItems: 14
> +
> +  arm,status-reporting:
> +    description:
> +      Bitmap indicating which implemented error records must be polled
> +      directly by the OS.  Bit N set to 1 means record N does not report
> +      through the ERRGSR and must be polled by reading its ERX_STATUS
> +      register directly in the interrupt handler.  Bit N set to 0 means
> +      record N reports its status through the ERRGSR and will be discove=
red
> +      via the ERRGSR scan path.  For system-register nodes (no reg prope=
rty)
> +      there is no ERRGSR, so every implemented record must be polled
> +      directly; arm,status-reporting must equal arm,record-impl for all
> +      system-register nodes.  Array length as for arm,record-impl.
> +    $ref: /schemas/types.yaml#/definitions/uint64-array
> +    minItems: 1
> +    maxItems: 14
> +
> +  arm,addressing-mode:
> +    description:
> +      Bitmap indicating the type of address reported in the error address
> +      register (ERX_ADDR) for each error record.  Bit N set to 0 means
> +      record N reports a System Physical Address (SPA) that the OS can u=
se
> +      directly.  Bit N set to 1 means record N reports a node-specific
> +      Logical Address (LA) that requires platform-specific translation to
> +      obtain a SPA.  Array length as for arm,record-impl.
> +    $ref: /schemas/types.yaml#/definitions/uint64-array
> +    minItems: 1
> +    maxItems: 14
> +
> +  # Processor error source properties (arm,ras-processor only)
> +
> +  cache:
> +    description:
> +      Phandle to the cache node (L1, L2, or L3) that this processor error
> +      source monitors.  The referenced node must have compatible =3D "ca=
che"
> +      and a cache-level property identifying the level in the hierarchy.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  # SMMU error source properties (arm,ras-smmu only)
> +
> +  iommus:
> +    description:
> +      Phandle to the SMMU node that this error source monitors.
> +    maxItems: 1
> +
> +  # GIC error source properties (arm,ras-gic only)
> +
> +  arm,gic-ref:
> +    description:
> +      Phandle to the GIC node that this error source monitors.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +required:
> +  - compatible
> +  - arm,num-records
> +  - arm,record-impl
> +  - arm,status-reporting
> +
> +allOf:
> +  - if:
> +      required:
> +        - reg
> +    then:
> +      required:
> +        - arm,group-format
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: arm,ras-processor
> +    then:
> +      required:
> +        - cache
> +      properties:
> +        cache: {}
> +    else:
> +      properties:
> +        cache: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: arm,ras-smmu
> +    then:
> +      required:
> +        - iommus
> +      properties:
> +        iommus: {}


What is with this syntax. There is no such style, drop.


> +    else:
> +      properties:
> +        iommus: false
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: arm,ras-gic
> +    then:
> +      required:
> +        - arm,gic-ref
> +      properties:
> +        arm,gic-ref: {}

Drop. This is not an object, but phandle.

> +    else:
> +      properties:
> +        arm,gic-ref: false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/arm/arm-ras.h>
> +
> +    / {
> +        compatible =3D "qcom,sa8775p-ride", "qcom,sa8775p";
> +        model =3D "Qualcomm Technologies, Inc. SA8775P RAS example";
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +        interrupt-parent =3D <&intc>;

Drop, irrelevant.

> +
> +        intc: interrupt-controller@17100000 {
> +            compatible =3D "arm,gic-v3";
> +            reg =3D <0x0 0x17100000 0x0 0x10000>,
> +                  <0x0 0x17180000 0x0 0x100000>;
> +            interrupt-controller;
> +            #interrupt-cells =3D <3>;
> +            #address-cells =3D <2>;
> +            #size-cells =3D <2>;
> +        };
> +
> +        cpus {
> +            #address-cells =3D <2>;
> +            #size-cells =3D <0>;
> +
> +            cpu0: cpu@0 {
> +                device_type =3D "cpu";
> +                compatible =3D "arm,armv8";
> +                reg =3D <0x0 0x0>;
> +                next-level-cache =3D <&l2_0>;
> +
> +                l2_0: l2-cache {
> +                    compatible =3D "cache";
> +                    cache-level =3D <2>;
> +                    cache-unified;
> +                    next-level-cache =3D <&l3_0>;
> +
> +                    l3_0: l3-cache {
> +                        compatible =3D "cache";
> +                        cache-level =3D <3>;
> +                        cache-unified;
> +                    };
> +                };
> +            };
> +        };

Drop all the nodes above, irrelevant.

> +
> +        /*
> +         * Per-PE L1/L2 cache RAS error source.  System-register access,
> +         * per-CPU PPI.  Record 0 is implemented (arm,record-impl bit 0
> +         * set).  arm,status-reporting equals arm,record-impl because
> +         * system-register nodes have no ERRGSR; record 0 must be polled.
> +         */
> +        ras-l1l2-0 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetr=
ee-basics.html#generic-names-recommendation
If you cannot find a name matching your device, please check in kernel
sources for similar cases or you can grow the spec (via pull request to
DT spec repo).

Choose some generic name, but l1l2 does not sound like one.

> +            compatible =3D "arm,ras-processor";
> +            arm,num-records =3D <1>;
> +            arm,record-impl =3D /bits/ 64 <0x1>;
> +            arm,status-reporting =3D /bits/ 64 <0x1>;
> +            cache =3D <&l2_0>;
> +            interrupts =3D <GIC_PPI 0 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names =3D "fhi";

I had impression we agreed all this is part of actual CPU/GIC/cache node
or its subnode.

Keeping it separate does not feel right, if cache is the source of error re=
porting.

> +        };
> +
> +        ras-l3-cluster0 {
> +            compatible =3D "arm,ras-processor";
> +            arm,num-records =3D <2>;
> +            arm,record-impl =3D /bits/ 64 <0x2>;
> +            arm,status-reporting =3D /bits/ 64 <0x2>;
> +            cache =3D <&l3_0>;
> +            interrupts =3D <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names =3D "fhi";
> +        };
> +    };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/arm/arm-ras.h>
> +
> +    / {
> +        compatible =3D "qcom,sa8775p-ride", "qcom,sa8775p";
> +        model =3D "Qualcomm Technologies, Inc. SA8775P RAS example";
> +        #address-cells =3D <2>;
> +        #size-cells =3D <2>;
> +        interrupt-parent =3D <&gic>;
> +
> +        /*
> +         * GICv3 interrupt controller with RAS support.
> +         */
> +        gic: interrupt-controller@17b00000 {
> +            compatible =3D "arm,gic-v3";
> +            reg =3D <0x0 0x17b00000 0x0 0x10000>,
> +                  <0x0 0x17b60000 0x0 0x100000>;
> +            interrupt-controller;
> +            #interrupt-cells =3D <3>;
> +        };
> +
> +        ras-gic-dist@17a00000 {
> +            compatible =3D "arm,ras-gic";
> +            reg =3D <0x0 0x17a00000 0x0 0x10000>;
> +            reg-names =3D "err-group";
> +            arm,group-format =3D <ARM_RAS_GROUP_4K>;
> +            arm,num-records =3D <1>;
> +            arm,record-impl =3D /bits/ 64 <0x1>;
> +            arm,status-reporting =3D /bits/ 64 <0x0>;
> +            arm,gic-ref =3D <&gic>;
> +            interrupts =3D <GIC_SPI 200 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names =3D "fhi";
> +        };
> +    };
> diff --git a/include/dt-bindings/arm/arm-ras.h b/include/dt-bindings/arm/=
arm-ras.h
> new file mode 100644
> index 000000000000..c2f4e1f8243e
> --- /dev/null
> +++ b/include/dt-bindings/arm/arm-ras.h

Filename must match binding or compatible.

> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +
> +#ifndef _DT_BINDINGS_ARM_RAS_H
> +#define _DT_BINDINGS_ARM_RAS_H

Best regards,
Krzysztof

