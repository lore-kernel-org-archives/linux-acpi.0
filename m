Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795195294;
	b=PufQr0+VfhkHZhp4pCxz97xHyiEr3zAREUXQqQEgFIQOofeGvQh4z3GKeN3Vj7rx5xam
	 rEbvYggEf+m849cHl7bfpmD0MAW9mvShu+pIK/lHLl2FlDZy4PLhxv1sRswQus73tMQ91
	 ITnkSB8PucyMVU6eyWABog9sz29VNSTbK84trNRjVZ/dOLP+MDdFZxna25gAoQ5EeDEwL
	 10eShdZsy8uteTDLo2sYlkUjdlKweBo6QSvQUmHjDuY2wDQf6IuHJ15+udMb+HN+PY1gw
	 tJ2TrusphuuSWnY1RLTdgWI1Mft0zznyaLCNyv+NMPqHxHII/iqrKS0xs7KVJflSUPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195294;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t1iSABh24B4vqNjNqk/PuMVMp4ndrA9W0AbohqmlAnE=;
	b=mBqrnhu1rqB8Qq18CJlIdP5/7XUI1CWOqLtAoQeXupdYJ0SW+Arjfw6LRnbEJ5iyNVor
	 KFjHEsmUFmmFnVkcs9G4pDSLx6gY/ToIembhl0CR1Ib4+NQI7CWcBFxIob/RwjC4jmbuR
	 mgsVYflnLQq8quAiswoFqFn3pDtDPFg8SWePubomdvnPdqL8g5ksxJEwt2Mcex7+kTDKw
	 euLd2bJSUoBlluGAER0MmP5m92HyAHzRhMbtKXU/3oi10upTZmql6f1xpfvDvZ4OdpBoE
	 7qlZTkAbYdOZC7XipHi2c5PKLP3sowEbogVbJ6T762WH7HJjXuNU3etxZEkH5yYUR6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ioHxq7bf;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914D860A383A;
	Fri, 20 Nov 2026 17:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 914D860A383A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ioHxq7bf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795195293; x=1826731293;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/qaIxDahUGh/hHepfq5P8ilVmN9LUSnnLNKjIkPQggI=;
  b=ioHxq7bfZfTnktxx86VyKZbkQjm+63ycXgt/NtPzctNXmdQsD+Yc82Oi
   K9jrX/oP+m1D5xpM6IJNij04EEjWSPiuXou77IcQBhfgM0xQhFou9vLxc
   W0t+Ksqar7mXk9gUNdvZmovVMjTs2BUM1g+BpIr5EMcJaEGz79jAhppPM
   bng8svQEjjQ355F5ZuTZJrNF1fY51EK2Dv9oMNaPi3xGzPqI0UA/eQkDb
   wV3DOldSfPpAun695nOclyR4V77rUhD7v2z8QYlmwqLTl/y5AVLT271fc
   qwqFQG55AxZFBEVZ2GEkFMJXwMl/FXF1XZ8jouqtUHsc3Dh8BM6zVDfw6
   A==;
X-CSE-ConnectionGUID: U85yliuaS8GNrOYZ6HX3UA==
X-CSE-MsgGUID: c9L3Eg3DRKibsgs+M9y5/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4157507"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4157507"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:33 -0800
X-CSE-ConnectionGUID: /W3H3v2STMiMRhbvCw36lw==
X-CSE-MsgGUID: b+eXtxC1TZ6+hdGoVfGSrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10868189"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO wieczorr-mobl1.intel.com) ([10.245.245.215])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 09:21:30 -0800
From: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Len Brown <lenb@kernel.org>
Cc: Iurii Trukhin <yuri@trukhin.com>,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 29/42] ACPICA: parser: Fix parse tree memory leak on AML execution error unwind
Date: Fri, 20 Nov 2026 18:18:50 +0100
Message-ID: <37d308175937846fedd3d81d786831906e746dbd.1795194329.git.maciej.wieczor-retman@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
References: <cover.1795194329.git.maciej.wieczor-retman@intel.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Iurii Trukhin <yuri@trukhin.com>

AcpiPsCompleteThisOp() checks WalkState->OpInfo->Class when deciding
whether to defer deletion of an AML_CLASS_ARGUMENT parse object to its
parent. During error unwind, however, WalkState->OpInfo can still refer
to the child that failed while Op refers to an enclosing scope.

If that child is an AML_INT_NAMEPATH_OP, the enclosing parse subtrees
are skipped as well. A nested control method has RootOp = NULL, so an
unattached top-level If subtree can leak on every failed evaluation.

Look up the opcode class of Op directly and only defer argument-object
deletion when Op has a parent. Preserve WalkState->Opcode, which the
parser still uses when skipping failed module-level scopes. Remove the
extra region-error AcpiPsDeleteParseTree() call now that completion owns
that deletion, and return discarded control states through
AcpiUtDeleteGenericState() instead of freeing cached objects directly.

Tested with native iASL and acpiexec using a nested _GPE._L6F method
whose If predicate calls a missing external _STA method. The unpatched
interpreter leaves 64 parse objects after 32 evaluations; the patched
interpreter leaves none. Both retain the expected AE_NOT_FOUND result.
Normal If/Return evaluations continue to return 0 and 42.

Link: https://github.com/acpica/acpica/commit/2627fccee606
Link: https://bugzilla.kernel.org/show_bug.cgi?id=221241
Link: https://lore.kernel.org/all/CAOx7e9+Vv8Pdyks=AbE5XG0ZyDgtKToKyBLTnt+H5RPn6VymVg@mail.gmail.com/
Signed-off-by: Iurii Trukhin <yuri@trukhin.com>
Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
---
 drivers/acpi/acpica/psloop.c   |  5 +++--
 drivers/acpi/acpica/psobject.c |  1 -
 drivers/acpi/acpica/psparse.c  | 16 ++++++++++++----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 24a57f971c96..f67bc2f3dc42 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -464,8 +464,9 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 						walk_state->aml =
 						    parser_state->aml;
 					}
-					ACPI_FREE(acpi_ut_pop_generic_state
-						  (&walk_state->control_state));
+					acpi_ut_delete_generic_state(
+						acpi_ut_pop_generic_state(
+							&walk_state->control_state));
 				}
 				op = NULL;
 				continue;
diff --git a/drivers/acpi/acpica/psobject.c b/drivers/acpi/acpica/psobject.c
index 629cafab1930..f1425b98087b 100644
--- a/drivers/acpi/acpica/psobject.c
+++ b/drivers/acpi/acpica/psobject.c
@@ -559,7 +559,6 @@ acpi_ps_complete_op(struct acpi_walk_state *walk_state,
 								node);
 					acpi_ns_remove_node((*op)->common.node);
 					(*op)->common.node = NULL;
-					acpi_ps_delete_parse_tree(*op);
 				}
 
 				status2 =
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index 42ec8abef626..aa89bad57647 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -108,6 +108,7 @@ acpi_ps_complete_this_op(struct acpi_walk_state *walk_state,
 {
 	union acpi_parse_object *prev;
 	union acpi_parse_object *next;
+	const struct acpi_opcode_info *op_info;
 	const struct acpi_opcode_info *parent_info;
 	union acpi_parse_object *replacement_op = NULL;
 	acpi_status status = AE_OK;
@@ -122,11 +123,18 @@ acpi_ps_complete_this_op(struct acpi_walk_state *walk_state,
 
 	acpi_ex_stop_trace_opcode(op, walk_state);
 
-	/* Delete this op and the subtree below it if asked to */
-
+	/*
+	 * Delete this op and the subtree below it if asked to
+	 *
+	 * Derive op_info from Op instead of using walk_state->op_info. While they are
+	 * often synonymous it is different during error unwind (in acpi_ps_complete_op).
+	 * Then the latter can describe a failed child object instead of the enclosing
+	 * operation that we want to handle here.
+	 */
+	op_info = acpi_ps_get_opcode_info(op->common.aml_opcode);
 	if (((walk_state->parse_flags & ACPI_PARSE_TREE_MASK) !=
-	     ACPI_PARSE_DELETE_TREE)
-	    || (walk_state->op_info->class == AML_CLASS_ARGUMENT)) {
+	     ACPI_PARSE_DELETE_TREE) ||
+	    ((op_info->class == AML_CLASS_ARGUMENT) && op->common.parent)) {
 		return_ACPI_STATUS(AE_OK);
 	}
 
-- 
2.56.0

