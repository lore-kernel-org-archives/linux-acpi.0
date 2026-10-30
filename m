Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793371930;
	b=IbHqBIX5Fdv5JPv5Eiwm164B8nZtJYe1rhQ6g98SA2EQGHTC4UdtsEcKrn/+YPxvGgTL
	 CsWJnH0FTVD7JI9rJbGD7v0hHsqdqkLeUNsxcubbg96Qil5KyH/h1Mb6tXA3LB7EOSO3u
	 cPNRXFILXaSR94RBPWDYhFekI2/jFBb/immb0poI0y79z+QgBeCmFDAmb4QOeBI6oCrHp
	 L8doQ31rgWZuZywKoe+1Xmo/iEgallyWZN3d3hjH/fBgLYbddrA1MD3Z0zjZXKel+n48F
	 2SIN9VQ2eW/xxBzzv39sr2YdqgFQGoMiei13hIn2CEZkjXw5yI8VvjzJIb878+cmqRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371930;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=IynCA/CXHHxpvBVvDUwuv5p+dERMEHS5aKDO2xZbSGI=;
	b=ANsKcV/UZ3ItdOhj5UzmupF7LigHJvv58Sq9Y6V3JYeRcU3O8c42dE0aCKDJL6JND5PP
	 bYVv+2X02SNG9BOtHc7MIjd925RxX69NkLBT7xG+NVEZGVu3HSoRNHWctd+wRQrRVlGxk
	 lMDjXQubJ18c0D8DYzJe1wJBBTw2sHqj9P6Z1tCzhKiZ1KWS8fB1SlRUU1IfGolfJvy4A
	 C4ERqDpfhawhCfBPg1tQk4EtuAvROad9io6Mi9Iw5Cxo2VF5HnZqzQARzLUWt08kACOMr
	 JRuaA/4jOd0qcZwGSXCtnRGknkvMd7ax4k3zy9dlbzKXUPQ4vhBbBSlVy2Aw1Lwz98g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIV366cj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17F1606A325;
	Fri, 30 Oct 2026 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hIV366cj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89331F00A02;
	Fri, 30 Oct 2026 14:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793371929;
	bh=IynCA/CXHHxpvBVvDUwuv5p+dERMEHS5aKDO2xZbSGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hIV366cjcNsvxIP7LxLTIg+RpNbiujGvx4EXw47fMFYNX+tjxcuEB+Mbt2xNJtb/6
	 KuuSzmtIr0mrHfDyrMgLMdua+MtGvkCfI7/OSinyLYXuzV1r52JYt6l7zUGX5p7PXm
	 mBpWGEilcuteN47a8ioT4ukPSCrp+sd00HICugXaSlYdjUOeL3lcSiSsk9Ns17vsNx
	 SgkqzRD1KI2eeG7wwumI06PYgWF/8fWuXlLCorFRhnGNosYr2sy3Co4OGjaVuVl5Rk
	 T/PIVxMiXGgd8PxnVP3O5KRBE+UVon3PdKiGpSR58R5sjmbMdO3OwXGd4H+kJJQChN
	 CAgpMR8SPP+zA==
Message-ID: <c018e549-6d31-40fc-9b82-05b53d4dac22@kernel.org>
Date: Fri, 30 Oct 2026 09:52:08 -0500
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: runtime resume dGPU on ACPI notify from
 its own node
Content-Language: en-US
To: Mike Lothian <mike@fireburn.co.uk>, Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261030075735.356811-1-mike@fireburn.co.uk>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20261030075735.356811-1-mike@fireburn.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/30/26 02:57, Mike Lothian wrote:
> On Thu, 29 Oct 2026, Alex Deucher wrote:
>> I'm not sure about BACO.  In the BOCO case the OEM has a mux on the HPD
>> pins that redirects them to the EC when the dGPU is powered off.  For
>> BACO it's usually a PCIe add-in board so there is no way to redirect
>> the HPD pins.
> 
> Agreed, and I can't test BACO anyway, so I'll keep it BOCO only in v2
> Mario, sorry, I'll leave your BACO suggestion out unless someone has a
> board that needs it

No problem.

> 
>> Mike Lothian does your system have ATIF?  This is already code to
>> handle this.  It sounds like it's just registering the wrong ACPI node.
>> You should be able to use the existing handler.
> 
> It does, but only on the iGPU: ATIF is in SSDT7 under \_SB.PCI0.GP17.VGA_,
> and the dGPU node (\_SB.PCI0.GPP0.SWUS.SWDS.VGA_) has none
> 
> What arrives here isn't an ATIF notification either.  _L05 in SSDT9 is
> just Notify (\_SB.PCI0.GPP0.VGA, 0x81), and that path doesn't exist on
> this board, so the interpreter aborts the method with AE_NOT_FOUND and no
> Notify is delivered to anything.  I've put the tables and the errors in
> a bug: https://gitlab.freedesktop.org/drm/amd/-/work_items/6061

Yeah looking at the tables this does look like a BIOS bug.  So quirking 
it somewhere feels appropriate.

> 
> What I haven't checked is whether the firmware would flag a dGPU display
> event in the ATIF SBIOS requests if the Notify did arrive at the right
> node.  If I alias the path so it resolves, I can turn on drm.debug and see
> whether amdgpu_atif_handler() fires and what request flags come back, and
> if ATIF_DGPU_DISPLAY_EVENT is set I'll use the existing handler rather
> than add a new one.  I'll report back
> 
> Mike

