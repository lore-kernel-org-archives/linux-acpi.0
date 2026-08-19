Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCA822083;
	Wed, 19 Aug 2026 20:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787170558; cv=none; b=u4N6nj2tS2G4z79O+asHj53JFdymxUO8oNa9c6pxVBG8WjtYuxIC8MrqwacXlOUHw0jNXLWtRq9V4zHSt5vBwQdPLMCfQo66WnkkBdS9LRp9QA9rbFxt99i/UXDyRKRs4htL1mU5z2XcZIJ79eAaDTx+cNUmN0E7IEWNAE9ZPY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787170558; c=relaxed/simple;
	bh=eiR7AEPExJRfS9L8W7Y0DasFSP/eCKLDmgr7DeWSJVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQ39sJlqxAutvUxRFg2xegwyhuirz56HF2q9ne2iX0VBNBMfdG0sK/Uv0TTNWUOWW4uN9CQbdD/vQUOuwcrjNtW0N9jOmCPOmM3WwAAmLSodAXHyRgrBLtSnEmAcVpjpu1JSj1jcDsM9V5ngjpnvEzQ/bHCPCSvQnivXwfkMNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WLJksdSQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WLJksdSQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60BF01F000E9;
	Wed, 19 Aug 2026 20:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787170557;
	bh=Co8UH/flwlcLr7iQK+8PpYPN9SoQE1REBl+L/X3+I/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WLJksdSQV5yiImf57JJXwryd0ogtHH2J0MqCW/pOsvm8gvD1JOFoT1rZz+YiedgtJ
	 36Hr4TLPSW1B+EkAuCOKjiBF6Vsd1WAhucMddnMWloWTAsQVqQMEVK/F2Hyu0pLJsD
	 cOFLDQ88f957H9qzddTE9mDuwDFwlnZbpKo3Uj2+VC7L0nttdSLnbXT2qouT6zIHvK
	 3ZZgX7sqHuDKE9fVIf+/qZjFRw0tJoFnI3z4cmmryq40/xuAeVVVjTUggr+tBQI/mM
	 QEMn9IUg8HonUrB3wYVeVJjb0QcmJwr1p1rdMrILwunePshzvZbGWu5dmDx1aBJrRq
	 DXdH5zXiIHEgw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Armin Wolf <w_armin@gmx.de>,
 Colin Ian King <colin.i.king@gmail.com>, acpica-devel@lists.linux.dev,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v1 3/3] ACPI: Update upstream ACPICA repository URL in documentation
Date: Wed, 19 Aug 2026 22:14:10 +0200
Message-ID: <1867400.VLH7GnMWUR@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <7982261.EvYhyI6sBW@rafael.j.wysocki>
References: <7982261.EvYhyI6sBW@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Update the URL of the upstream ACPICA repository after recent changes in
the upstream ACPICA project.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/driver-api/acpi/linuxized-acpica.rst |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/Documentation/driver-api/acpi/linuxized-acpica.rst
+++ b/Documentation/driver-api/acpi/linuxized-acpica.rst
@@ -117,7 +117,7 @@ ACPICA Release
 ==============
 
 The ACPICA project maintains its code base at the following repository URL:
-https://github.com/acpica/acpica.git. As a rule, a release is made every
+https://github.com/open-acpica/acpica.git. As a rule, a release is made every
 month.
 
 As the coding style adopted by the ACPICA project is not acceptable by
@@ -173,7 +173,7 @@ illustrated in the following figure::
        utility located in source/tools/acpisrc folder and a number of
        scripts located in generate/linux folder.
     B. acpica / master - "master" branch of the git repository at
-       <https://github.com/acpica/acpica.git>.
+       <https://github.com/open-acpica/acpica.git>.
     C. linux-pm / linux-next - "linux-next" branch of the git repository at
        <https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git>.
     D. linux / master - "master" branch of the git repository at
@@ -244,7 +244,7 @@ before they become available from the AC
    Then the gen-patch.sh command can help to cherry-pick an ACPICA commit
    from the ACPICA local repository::
 
-   $ git clone https://github.com/acpica/acpica
+   $ git clone https://github.com/open-acpica/acpica
    $ cd acpica
    $ generate/linux/gen-patch.sh -u [commit ID]
 
@@ -259,7 +259,7 @@ before they become available from the AC
    You can generate the ACPICA release series yourself and rebase your code on
    top of the generated ACPICA release patches::
 
-   $ git clone https://github.com/acpica/acpica
+   $ git clone https://github.com/open-acpica/acpica
    $ cd acpica
    $ generate/linux/make-patches.sh -u [commit ID]
 
@@ -273,7 +273,7 @@ before they become available from the AC
    If you have local copies of both Linux and upstream ACPICA, you can generate
    a diff file indicating the state of the current divergences::
 
-   # git clone https://github.com/acpica/acpica
+   # git clone https://github.com/open-acpica/acpica
    # git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
    # cd acpica
    # generate/linux/divergence.sh -s ../linux



