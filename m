Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F7D23393D;
	Tue, 19 May 2026 13:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196636; cv=none; b=tTJ3eqCxIH7QgDSOGSfPymnoaEp6jlW4kCexAYRVoivVgz/tQtWMq485YVDb2E2UR8W8tQ/K2MWyoq6754t5IiLOMqrIf/jdDeuP4+9O9QHPUPo88y54EYJ14YV0lFuIs0SRs8JJ3W0O1EG5mNGjQJ3FV9fRkHgpsoMzYWaCtRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196636; c=relaxed/simple;
	bh=kUeIDw2Ng9suzTxDeE2KvE6gHW9XGNMheoyVDX1/y6A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PrLMVzQSNZz7VahyAjx/bhK3OY+8K4ZjSyeiP97Q7tKvK+IikcDaNDF6xApSLx2diS0/JMOho08penJuCq54JD1FZwYeePTbbPbbXszx9fbLGmO1b2Fwkrv9zyxXN9LNmKE3MrRawfivOHten4qaF0yldLDvW5coNPPI9ANeJ6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdUHgCGl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdUHgCGl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779196635; x=1810732635;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=kUeIDw2Ng9suzTxDeE2KvE6gHW9XGNMheoyVDX1/y6A=;
  b=YdUHgCGlhu4Q8f8j70lxRDFgejwyRZ3krXYAhCJWZWCk1pYmexgYhWDq
   XNe09JQE+bSHHVAry7GL7vYsLl4QmtujMic+s9TM97VyRWa4qudTLQdQz
   VnEK6UoAdIZC+Q8h9kGjnZ1TvqNhjNQtNgeug5p9ChirOmdXlkUAzVusX
   UIQ50Djl798rGLhZPpJ9T+5OXNmMrfg0SDlUaJaAN+s8EX31pdAeoeeNk
   G8uyjJ9qYHs3NLXBAMPpI5nbwcRRYdceh4cVFdUjYdFuvJD2s1yE+eFVJ
   mMOOk1E/ZJ9K1clebTW4aJXj7DRHdt9qZm34jiZAhokUC33G5P31TPIqz
   Q==;
X-CSE-ConnectionGUID: uMvQIyEZRYWBgYqiW7cdvA==
X-CSE-MsgGUID: bPfd3CfxR2aasJt9kHsjPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="67600821"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="67600821"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 06:17:14 -0700
X-CSE-ConnectionGUID: yI1boj+LS/OigIFRKzSMYQ==
X-CSE-MsgGUID: 0vSba3VZS9+sdUvqeWO/AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="263277105"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.236])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 06:17:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
 Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
 platform-driver-x86@vger.kernel.org, 
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
In-Reply-To: <3415394.44csPzL39Z@rafael.j.wysocki>
References: <3415394.44csPzL39Z@rafael.j.wysocki>
Subject: Re: [PATCH v2 00/10] platform/x86: classmate-laptop: Bind to
 platform devices instead of ACPI ones
Message-Id: <177919662711.13822.9649273823554227132.b4-ty@linux.intel.com>
Date: Tue, 19 May 2026 16:17:07 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0

On Mon, 11 May 2026 22:01:45 +0200, Rafael J. Wysocki wrote:

> This is an update of
> 
> https://lore.kernel.org/linux-acpi/1956046.tdWV9SEqCh@rafael.j.wysocki/
> 
> sent mostly because I have realized that using devm_kzalloc() in the first
> patch simplifies things going forward, but also it adds ACPI companion
> checks against NULL at probe time that were missing previously.
> 
> [...]


Thank you for your contribution, it has been applied to my local
review-ilpo-next branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-next branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[01/10] platform/x86: classmate-laptop: Address memory leaks on driver removal
        commit: 4727a7b46fb264ee85f5a5b858ebde97b1a424d8
[02/10] platform/x86: classmate-laptop: Unify probe rollback and remove code
        commit: 5a45e962ee10d756fc945057000122ac258f4c2b
[03/10] platform/x86: classmate-laptop: Pass struct device pointer to helpers
        commit: 9daf8ebbca4ab6ff0bb114d8b3dfa579c63ddfec
[04/10] platform/x86: classmate-laptop: Rename two helper functions
        commit: 491e41d697a4ef602b05aadc03f4a881b48cbdf8
[05/10] platform/x86: classmate-laptop: Register ACPI notify handlers directly
        commit: 8dbe106718efbcb72d175cc472ccae885fd6471e
[06/10] platform/x86: classmate-laptop: Convert v4 accel driver to a platform one
        commit: 2f677df5ceda1cbb8704ffad35d5fd2479e4a667
[07/10] platform/x86: classmate-laptop: Convert accel driver to a platform one
        commit: 01feb0f446c1fbdf1daee2d95b0206fa1a7c3548
[08/10] platform/x86: classmate-laptop: Convert tablet driver to a platform one
        commit: 966c5bfa52d89b8701963f8587d7eb9cbe1ae5fd
[09/10] platform/x86: classmate-laptop: Convert ipml driver to a platform one
        commit: b207f8c36ea1fceb9b924af3b956f42dafdfa657
[10/10] platform/x86: classmate-laptop: Convert keys driver to a platform one
        commit: d1f01dfa7f1fda58a95846dc2c5ce50a71e18580

--
 i.

