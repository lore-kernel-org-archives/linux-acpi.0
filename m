Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED734AF173;
	Fri, 25 Sep 2026 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346951; cv=none; b=VLWfulM8P9gVLdySiGmg3lSqdumb0QjbBCBVnijygRpGS0/TVQQ3hQIiOYY5fIcyRkxWG2LQcAmvTU65wsvlXpzWEbmTFUPaTgLPu8FbidCYsP8XOBONXtjkwt5ppP2wSgNS9eUy/YtR7ApHRNCbeeHWS2Ok5fSgt7xBK2qMvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346951; c=relaxed/simple;
	bh=yHlZ1EUgFp3f3yl/TRtS424OOtXdRMOYcISBfVBaLDI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gJ2APTCfMzSAAXXZZPF4jLWhEFrOsyzfjOj4yYghEe8UpEtA4adz0UCOXFCeHf9h926GwnqmI/rVcJAlPYIqCaN8KdH70gKOt+tfJE9ZBYOzAMZvuDSygc+33MW3c3VqALIkorOLWBOywf1RPZuRYJj0DXFFXzn3IjUUCyjkA7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jS0qw6ME; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jS0qw6ME"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=MSoHIOJ6rvzFSfecsi2inhTSF41NREEAhtQztx+1lM4=; b=jS0qw6ME24TMzorHz6+HFxZd2E
	g94xZpNqztxSM7qhOpm8pU3hvzCXrDAAfus5giu1Kx34B0eeLtwiO6dYGiiQQ8NDkca5vDzdBYqLI
	vmruQYz9g8ZhgwBscMQpGIQmsREygnhUnh719NEywYnNGGwNoCS1VFtN8PQOl+edrYR8A3CVYm6L6
	UYSKAVvZORim3W1jEWwaNaGopzSNAOUvcTjsfdHBROoYmwldHk6RCm8GDaQ0NV+YfdWZTGrh0lvDd
	5VGi9wwSpAxW3Fhj+xoTnZBhlivy6u8ztAaHvvzvgbLP/YgWLEOZSNk37KYIPQGZucfPt379FlH5G
	Gv0TkrJA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xA71J-005N46-0i;
	Fri, 25 Sep 2026 14:35:26 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 25 Sep 2026 07:35:10 -0700
Subject: [PATCH v2] ACPICA: Fix memory leak at acpi_ds_create_field()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-acpica-pcc-field-leak-v2-1-e37008e715af@debian.org>
X-B4-Tracking: v=1; b=H4sIAJ2GtmoC/4XNTQqDMBBA4auEWTvFKIk2K+9RXORnokNFQ1KkR
 bx7qRfo9i2+d0ChzFTAiAMy7Vx4W8GIphLgZ7tOhBzACGjqRte9bNH6xN5i8h4j0xJwIfvEPup
 OR6Vkd3dQCUiZIr8v9zFWAmYury1/rs0uf/WfuEuU2AbtVazJKdUNgRzb9bblCcbzPL/9xi07u
 wAAAA==
X-Change-ID: 20260813-acpica-pcc-field-leak-8f676f55179b
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Saket Dumbre <saket.dumbre@intel.com>, Len Brown <lenb@kernel.org>, 
 Sudeep Holla <sudeep.holla@kernel.org>, Bob Moore <robert.moore@intel.com>, 
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
 Pawel Chmielewski <pawel.chmielewski@intel.com>, 
 Erik Kaneda <erik.kaneda@intel.com>, Kyle Pelton <kyle.d.pelton@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 linux-kernel@vger.kernel.org, thepacketgeek@gmail.com, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2256; i=leitao@debian.org;
 h=from:subject:message-id; bh=yHlZ1EUgFp3f3yl/TRtS424OOtXdRMOYcISBfVBaLDI=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqtoanJuJAgsa8tBq5G55PA0VKyCpTyymfhwzVy
 Ls7sIC2ZwWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaraGpwAKCRA1o5Of/Hh3
 bTodD/9D45UTf99NRPB6oKj3d36ON+h4MqFPHv7nMUT1ZCXv/fuuJyhjmZB2BOVqsWXUFER63+U
 RguDiOj4hZq+tnLcTDUpwebWbWegjP0lbOWA0zuH6Y3phYV/+AGbAfO4I+lHPjHtpvSNHq4k765
 q87Ko3IBjbg4/qNPZ0zV11FDOvJxsyS5QmJ02xghLUrUDCza5SexGQPw1yRaRhz5tSR5wrwL40y
 4yilrBceGe9pNmy7L2m02OY9cErPDC76uyPDv7B4eXI/AshgkQD2zWJe0qO8DCeSss+/SY+Ed1A
 2rb16iXFGt5anp/G5euYowwrxg1bJgYENYzp0x1fOdxraqq6RXwGP6hCG2eeijDLLKEsSOSB3Ui
 nhhNnH+aZ30rKkRPI3ZYAkcDZB5vAuYpSAt+hx8hlE+Cap0OImK4DaPWeeR7z4RtMI46KS6o5s7
 uqmBzu0BQN0/+axAw1jVwjLsv5QZ3mUlt8J6l3zpRBM9/ZrEMr9FQ4rI4PHQJZhP2Kb4YeT2jju
 dG5ugrF0/qRP+30hx/BfbH0rl3OrCa1MfrDYJvdOct21/N52g9sstX0NfptQogCARVIeEWvVxzc
 nc1yq1gcxVPSP4tzJEeosAMYzolghDZN/NfOQ2pQhCy3QA/nrtcykCHxSfV9lPR7owE9gHEYUqt
 PvmTB4CJq1Kfk/g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

acpi_ds_create_field() allocates internal_pcc_buffer for operation
regions in the PCC address space.

The function runs once per field, so a second field on the
same region overwrites the pointer and orphans the previous buffer.

The matching ACPI_FREE() in acpi_ut_delete_internal_obj() only ever sees
the last one.

An arm64 platform whose SSDT declares regions with multiple fields each
leaks two buffers at boot, as detected by kmemleak:

  unreferenced object 0xffff000051e65400 (size 192):
    comm "swapper/0", pid 1, jiffies 4294668436
    backtrace (crc 0):
      __kmalloc_noprof
      acpi_ds_create_field
      acpi_ds_load2_end_op
      acpi_ds_exec_end_op
      acpi_ps_parse_loop
      acpi_ps_parse_aml
      acpi_ns_load_table
      acpi_load_tables
      acpi_init

Do not allocate a region if it was previously allocated before,
preserving the current design, but, not leaking memory.

Fixes: aa6ec56b574d ("ACPICA: ACPI 6.3: add PCC operation region support for AML interpreter")
Link: https://github.com/open-acpica/acpica/commit/c71849d476bb5f97ca1867849e893368e12a69e6
Signed-off-by: Breno Leitao <leitao@debian.org>
---
Changes in v2:
- Got the fix into ACPI CA first, and now respining this one with the
  Link to ACPI CA change.
- Link to v1: https://patch.msgid.link/20260813-acpica-pcc-field-leak-v1-1-3d6c5f0eb557@debian.org
---
 drivers/acpi/acpica/dsfield.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dsfield.c b/drivers/acpi/acpica/dsfield.c
index d7d56cc600d318..f7e503bf57c87c 100644
--- a/drivers/acpi/acpica/dsfield.c
+++ b/drivers/acpi/acpica/dsfield.c
@@ -522,7 +522,8 @@ acpi_ds_create_field(union acpi_parse_object *op,
 	}
 
 	if (info.region_node->object->region.space_id ==
-	    ACPI_ADR_SPACE_PLATFORM_COMM) {
+	    ACPI_ADR_SPACE_PLATFORM_COMM &&
+	    !region_node->object->field.internal_pcc_buffer) {
 		region_node->object->field.internal_pcc_buffer =
 		    ACPI_ALLOCATE_ZEROED(info.region_node->object->region.
 					 length);

---
base-commit: 4c253ac4b29b8c6cc6fdef8f92d4facde62e63b9
change-id: 20260813-acpica-pcc-field-leak-8f676f55179b

Best regards,
--  
Breno Leitao <leitao@debian.org>

