Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BCE369D59;
	Fri, 31 Jul 2026 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785530117; cv=none; b=OKXdS3UOJjPpgBe1kWyultqW9YCIxVcEgpWzJUR6odzC5zn/q6JLSN09sWpTCf7iNq+k/7zwty5Hbb/vpwjNokkewyY2RKpFJtdjsG9Xgx+EcQvw0WO0XxqSPDTlXCb0RFVON7kSDo5iV4M58hSD9OgGuqw+GaLkX3pBfdjGNhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785530117; c=relaxed/simple;
	bh=uA9qyBlrPYYjPC2CTTIGFM0Fv+fwiQo0Q5cdWC2o3Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=peazTKbxcvgOpuGNmqzMq42nPfYjt6tAIAVgBv08Nv9IQPnBArkmzzQVn5jSvrNB2lD6hADZDx02005irxgFe+v8WnLt4f9aX0yWZT5pxPFgVFBMKVNQwycemJPQtJtktB3plNHRf2KEFrtt33GefquIqF7TTVlkjL8uxUgFn/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MAnlS0XC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MAnlS0XC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED4B1F00AC4;
	Fri, 31 Jul 2026 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785530115;
	bh=1b7OOK1ydfjojKAeVm00aLNWdWN8CVli0QWCGJGGJH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MAnlS0XCeeG+IAX/DZqY8aetmPZb9L9iC68UYljTTm34OpK/T93OaKcoaWl9zDNlh
	 qfS3qG4bG0a/935rvi1QLUI64nC7w4TZ+f2cZIQSKsLCdTY9izrFbigFcQ9NBCQ1z6
	 IWGutnQJ3FiEYxA8SviAJheFFfSNnqA6V89hkE6axDb5jIcaUsHD0pIXRyuR1q1tPj
	 zkfQjMVrLUPIP6nzoWlQ+HmsipDG4EdYUFtdrptG22DwTY8mrFEGOf9FGQ0sOkqjAq
	 mlSn1vQL84YLakUibYG9bJuMBeyvIrfg8Vb0RyJx+vUOk/BnNVIP5+n86MG1itqxaP
	 SSeejGJ0poq4Q==
Date: Fri, 31 Jul 2026 15:35:15 -0500
From: Rob Herring <robh@kernel.org>
To: Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
	faruque.ansari@oss.qualcomm.com, avaneesh.dwivedi@oss.qualcomm.com
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: ras: Introduce bindings for ARM
 RAS error sources
Message-ID: <20260731203515.GA1619665-robh@kernel.org>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720081954.1858180-2-umang.chheda@oss.qualcomm.com>

On Mon, Jul 20, 2026 at 01:49:51PM +0530, Umang Chheda wrote:
> ARMv8 and later processors implement the RAS (Reliability,
> Availability and Serviceability) extensions, exposing hardware
> error records through a standardised register interface.
> 
> Add Device Tree bindings to describe RAS error sources.
> 
> Signed-off-by: Umang Chheda <umang.chheda@oss.qualcomm.com>
> ---
>  .../bindings/arm/arm,ras-error-source.yaml    | 330 ++++++++++++++++++
>  include/dt-bindings/arm/arm-ras.h             |  11 +
>  2 files changed, 341 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml
>  create mode 100644 include/dt-bindings/arm/arm-ras.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml b/Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml
> new file mode 100644
> index 000000000000..add7063a1a62
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/arm,ras-error-source.yaml
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
> +  Serviceability (RAS) extensions.  Hardware blocks that support RAS expose
> +  one or more error records through a standardised register interface.  Each
> +  error record captures information about a detected hardware error (cache
> +  ECC fault, TLB parity error, interconnect error, etc.) and can optionally
> +  signal the OS via an interrupt.
> +
> +  Each DT node described by this binding represents one RAS error source —
> +  a hardware block that exposes a set of error records.  Error records are
> +  accessed either through system registers (for processor-local resources
> +  such as L1/L2 caches and TLBs) or through a memory-mapped register window
> +  (for shared or off-core resources such as L3 caches, SMMUs and GICs).
> +
> +properties:
> +  compatible:
> +    description:
> +      Identifies the class of hardware block this error source belongs to.
> +      arm,ras-processor covers processor error sources (cache, TLB, etc.).
> +      arm,ras-smmu covers SMMU error sources.
> +      arm,ras-gic covers GIC error sources.
> +    enum:
> +      - arm,ras-processor
> +      - arm,ras-smmu
> +      - arm,ras-gic
> +
> +  reg:
> +    description:
> +      Register windows for this error source.  When absent the error records
> +      are accessed through system registers (ERRSELR_EL1 + ERX*_EL1).
> +      When present, the first range is the primary error-record window;
> +      additional named ranges are identified by reg-names.
> +    minItems: 1
> +    maxItems: 4
> +
> +  reg-names:
> +    description:
> +      Names for the optional additional register windows beyond the primary
> +      error-record window.  err-group is the error group status register
> +      window (ERRGSR).  fault-inject is the fault injection register window
> +      (ERXPFG*).  irq-config is the interrupt routing configuration window.
> +    minItems: 1
> +    maxItems: 3
> +    items:
> +      enum:
> +        - err-group
> +        - fault-inject
> +        - irq-config

reg and reg-names must be the same number of entries.

> +
> +  interrupts:
> +    description:
> +      Interrupts signalled by this error source.  The first interrupt is the
> +      Fault Handling Interrupt (FHI), fired when a corrected error counter
> +      overflows or a deferred error is detected.  The optional second
> +      interrupt is the Error Recovery Interrupt (ERI), fired when an
> +      uncorrected recoverable error is detected.
> +    minItems: 1
> +    maxItems: 2

Replace description with:

minItems: 1
items:
  - description:
      Fault Handling Interrupt (FHI), fired when a corrected error 
      counter overflows or a deferred error is detected.
  - description: 
      Error Recovery Interrupt (ERI), fired when an uncorrected 
      recoverable error is detected.


Seems backwards to me that corrected errors is required and uncorrected 
errors is optional. Should be fine to not care about corrected errors, 
but uncorrected errors can't really be ignored.

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

Define the order.

> +
> +  arm,group-format:
> +    description:
> +      Page granularity of the memory-mapped error record group register
> +      window.  Determines the ioremap size and the number of error group
> +      status registers (ERRGSR) available.  Required when reg is present.

Don't state constraints which are expressed as schemas.

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
> +      record N is present and active in this error source.  Bit N set to 0
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
> +      record N reports its status through the ERRGSR and will be discovered
> +      via the ERRGSR scan path.  For system-register nodes (no reg property)
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
> +      record N reports a System Physical Address (SPA) that the OS can use
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
> +      source monitors.  The referenced node must have compatible = "cache"
> +      and a cache-level property identifying the level in the hierarchy.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  # SMMU error source properties (arm,ras-smmu only)
> +
> +  iommus:
> +    description:
> +      Phandle to the SMMU node that this error source monitors.

If the iommu has #iommu-cells >0, then this property must match the cell 
size. You can't have your own definition of 'iommus'.

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

Better expressed as:

dependentRequired:
  reg: [ 'arm,group-format' ]

Rob
