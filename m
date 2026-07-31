Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25DD42E8EA;
	Fri, 31 Jul 2026 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512568; cv=none; b=t2rmENY+sPnFWXB86//epOvRThsBJgnSq3R3p5pkiF22uxAXOuF4fkOQG7Zz6JLQfR0/sUYFunwG/uWZx1U/LY/s56iwxfAhAI7u51iwRBruBXkCXOFcRhqxCTG4JroO4E+ymPfh5iYYfDbvkex694uzkZ/KfLbbW0Ye9AutQK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512568; c=relaxed/simple;
	bh=NzG/zqmBL02829RczNYC4rQ8LFgcwzItnPN67RnYGaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QxpqVekHleH3UBN4rvM8U3uTz1QLwGJo016qmI83Qt8dw+Ak8BM5EVKyBuNK62/PXEagu4YK16D2kl5Xkihgiu0q+j6NsVe6ghKlVb62xzBlPF45awLBdlEv1cwtfQIp3fJdKEalW7buFZhcAMvnMyj+yLXwOt/0A1dkidarOYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7R+oj68; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7R+oj68"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2571F00A3A;
	Fri, 31 Jul 2026 15:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785512567;
	bh=6yxmh3kK47cKyrwCahJrDCTnVsy69YxcsCTQmeW1UTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T7R+oj68nQ2c+GQA8Gu3e3yJkZzjmRYtHRpHRY8/mCykf7fJ59WezSSrkgnrqe3cC
	 YMiu6j9lLx/HZ7rVbN3vNipry01Km4BsoaHMl5OYow0ajGndleSWW+l1lo/7QeUzuJ
	 iDTnmI69niQmAVtPvW+6RAxUQoKeIRtFGzuQUUi04jis+c94taMvhFna2Dv1X1dLXU
	 MS3jr/X5qg5swxxUarsr8aLSUoovVbOVos3BunozvDHrbygHVezCoPKZQbfGqlej85
	 H95127MATL6fbcKcZpQhntdlTqtFeEG3fR4feiuWvzRHqKtJZ33QMGZRBQM5Jhy7hF
	 a9uaIWgRj8xBw==
Date: Fri, 31 Jul 2026 16:42:42 +0100
From: Will Deacon <will@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: IORT: validate RMR node array bounds
Message-ID: <amzCci9-3kMZbSI4@google.com>
References: <20260706094300.82618-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706094300.82618-1-pengpeng@iscas.ac.cn>

On Mon, Jul 06, 2026 at 05:43:00PM +0800, Pengpeng Hou wrote:
> IORT RMR nodes describe reserved-memory ranges through firmware
> offset and count fields inside the current IORT node.
> 
> Validate the generic IORT node length before dispatching it, and
> check both the RMR descriptor array and the ID mapping array before
> walking them.  This binds each array walk to the current node length
> instead of only trusting the firmware-provided count.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/acpi/arm64/iort.c | 83 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 79 insertions(+), 4 deletions(-)

Hanjun, Lorenzo, any thoughts on this one?

Will
