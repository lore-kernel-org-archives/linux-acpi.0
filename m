Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09CA13A86C;
	Wed, 25 Mar 2026 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774420667; cv=none; b=L5AEOHH5JCTRQbtroM7RPCjzWtGe51HJyvdR3VEkwq9YPo7l2o49DFTHeyQCiHV2DWBVtRFsl/x3r8S62glF8wjPT6LqnlSokxhpzxYTr9dO6kjQKNUbqh2kmrTcLlzH2vKA9XsyBE2f9ERX3brqeh1rxLtiboj6dP9FwqTnCos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774420667; c=relaxed/simple;
	bh=ZGxITZtXMJyi0rLNNXT23l4NyrRLV7JezCvW6G/F11w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UmNOZALuJ6noquIJzc59iw9eSE7YJbWGMKpD6cCYP6tdqlio+/ecKaKxjeoZFPa8AyVOonfwG4hBh00Q6EkgGsJzTx0VBOnf/67SvKNomHv/Pr8a9EG0HCgdPKeNkIGR94rNgtipverLEwuI9QjJAtpSid9OuJTmUe/IDCSnSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bGIbHMu4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bGIbHMu4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F154C4CEF7;
	Wed, 25 Mar 2026 06:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774420666;
	bh=ZGxITZtXMJyi0rLNNXT23l4NyrRLV7JezCvW6G/F11w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bGIbHMu4bZSK++1q0ZACYCqDEcOETLzBoJkW/iJDuYosU5JxLe2PGu7JliJTrMOAo
	 S2dRTTMYwr6xZU46JVjfW3LhoFmLaunIbdlwXBbBEWJLlmWrrPyeuB2Dj4mPCkCnqH
	 Pd9CI3u6DEaegGRiWnPuWx02LzKPeIV7q+hw3w7RCfJSp4MrK6Sp9nKJRrpuhgcTLJ
	 m8EvyKqvaAZlFyChg5+NpOEnVuWVDxWU1eQvDQsFjakH3J5phhj3KlXgFawX27Ft71
	 jF4s0wTCP1D9wNX/EtUN6Sq3USTWlaEQKxcPdIdAl+1UOPSrlOwlVxfT6UOs/n9iuc
	 2XV1HOCxyRFVQ==
Date: Tue, 24 Mar 2026 23:37:43 -0700
From: Drew Fustini <fustini@kernel.org>
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Adrien Ricciardi <aricciardi@baylibre.com>,
	Nicolas Pitre <npitre@baylibre.com>,
	Kornel =?utf-8?Q?Dul=C4=99ba?= <mindal@semihalf.com>,
	Atish Patra <atish.patra@linux.dev>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Chen Pei <cp0613@linux.alibaba.com>,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Weiwei Li <liwei1518@gmail.com>, guo.wenjia23@zte.com.cn,
	liu.qingtao2@zte.com.cn,
	Reinette Chatre <reinette.chatre@intel.com>,
	Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>,
	Peter Newman <peternewman@google.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
	Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, x86@kernel.org,
	Rob Herring <robh@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	devicetree@vger.kernel.org
Subject: Re: [External] [PATCH RFC v2 08/17] RISC-V: QoS: add resctrl
 interface for CBQRI controllers
Message-ID: <acOCt91J7ddr9I7A@gen8>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
 <20260128-ssqosid-cbqri-v2-8-dca586b091b9@kernel.org>
 <CAEEQ3wkvsY=1Ep4n35tR4AHor7D_ZE6oTqrbpXP7VwhUrzZqbw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEEQ3wkvsY=1Ep4n35tR4AHor7D_ZE6oTqrbpXP7VwhUrzZqbw@mail.gmail.com>

On Wed, Mar 25, 2026 at 10:09:01AM +0800, yunhui cui wrote:
> Hi Drew,
> 
> On Thu, Jan 29, 2026 at 4:28 AM Drew Fustini <fustini@kernel.org> wrote:
> >
> > Add interface for CBQRI controller drivers to make use of the resctrl
> > filesystem.
> >
> > Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
> > Signed-off-by: Drew Fustini <fustini@kernel.org>
> > ---
> >  arch/riscv/kernel/qos/qos_resctrl.c | 1192 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 1192 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/qos/qos_resctrl.c b/arch/riscv/kernel/qos/qos_resctrl.c
> > new file mode 100644
> > index 000000000000..d500098599d2
> > --- /dev/null
> > +++ b/arch/riscv/kernel/qos/qos_resctrl.c
> > @@ -0,0 +1,1192 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +
> > +#define pr_fmt(fmt) "qos: resctrl: " fmt
> > +
> > +#include <linux/slab.h>
> > +#include <linux/err.h>
> > +#include <linux/riscv_qos.h>
> > +#include <linux/resctrl.h>
> > +#include <linux/types.h>
> > +#include <asm/csr.h>
> > +#include <asm/qos.h>
> > +#include "internal.h"
> > +
> > +#define MAX_CONTROLLERS 6
> > +static struct cbqri_controller controllers[MAX_CONTROLLERS];
> 
> We can get the total number of controllers, so we'll allocate dynamically.

I've made a lot of improvements but am still making more changes based
on the feedback from Reinette and you. I'm hoping to finish and send a
new revision of the series but in the meantime my work-in-progress is
b4/ssqosid-cbqri-rqsc [1].

I have dropped this static array and now just use a list of controllers.
It is populated by drivers/acpi/riscv/rqsc.c [2] and iterated through by
qos_resctrl_setup() in arch/riscv/kernel/qos/qos_resctrl.c [3].

[1] https://github.com/tt-fustini/linux/tree/b4/ssqosid-cbqri-rqsc
[2] https://github.com/tt-fustini/linux/blob/b4/ssqosid-cbqri-rqsc/drivers/acpi/riscv/rqsc.c
[3] https://github.com/tt-fustini/linux/blob/b4/ssqosid-cbqri-rqsc/arch/riscv/kernel/qos/qos_resctrl.c

> > +static int qos_resctrl_add_controller_domain(struct cbqri_controller *ctrl, int *id)
[..]

> 1. Wrap this into a function.
> 
> 2. Also, mweight controller support needs to be added here.
> We may need to add RDT_RESOURCE_MB_WEIGHT to the enumeration:
> enum resctrl_res_level {
> ...
> RDT_RESOURCE_MB_WEIGHT,
> ...
> };
> 
> 3. We need to implement cbqri_set_mweight() and cbqri_get_mweight().

I think this could be a good way to implement mweight but I am planning
to intiailly support justI think this could be a good way to implement
mweight but I am planning to intiailly support just rbwb
 
> 4. We need to add monitor controllers (domains) for both capacity and MBW.

I don't want to attempt to support bandwidth monitoring until there is
progress in resctrl for support of cpu-less memory devices as this is a
concern for mpam too. However, it should be possible to support cache
occupancy monitoring.

[..]
> > +       pr_info("exposed_alloc_capable = %d", exposed_alloc_capable);
> > +       pr_info("exposed_mon_capable = %d", exposed_mon_capable);
> > +       pr_info("exposed_cdp_l2_capable = %d", exposed_cdp_l2_capable);
> > +       pr_info("exposed_cdp_l3_capable = %d", exposed_cdp_l3_capable);
> 
> One line of pr_info? Print total controllers, capacity and MBW counts

Good idea, I'll do that.

Thanks,
Drew
