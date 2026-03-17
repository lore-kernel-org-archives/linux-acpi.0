Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B918D342507;
	Tue, 17 Mar 2026 19:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776092; cv=none; b=BXE9D3EA39Kz1kiRTx2WCE6BjZ55UKrjOyCJCBRP24WXUoSqYBPxoXCYaHxEbqsad0kRwQt1fXW2C2HiRuc6klyuSH3+V2x7abDF9NPvSXWKWIuPIz5Mgw8L7dy0yteFnt6sEUxaiR6CfnLocvajDlgQ9gPEp6XS8dysEK6NJ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776092; c=relaxed/simple;
	bh=UtdJ3xs5N6JPkzFLFluWNbrCO06qaMfVyYCs6W2Rg3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Bb8g3bSBd4BlZE7sVgx5cRkMpq0NKOrfdi8HKAV3RNCZRQfwyZDOqKZ4p8e+eaPLyXaD9yfvpT24BkBPYcxrRmXA/Vjywk5S+Ip2uMaj139kmrDxjyRqnurWcntxH/sersBeTTssfw2kOxlLh9EAKgYO7qbR9JwQCQSeBmBbO0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrDDqRzf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrDDqRzf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B5BC4CEF7;
	Tue, 17 Mar 2026 19:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773776092;
	bh=UtdJ3xs5N6JPkzFLFluWNbrCO06qaMfVyYCs6W2Rg3s=;
	h=From:To:Cc:Subject:Date:From;
	b=rrDDqRzfhIamLGNWCKETZLFK7KkYZhDE644dmX+gERqmaTy6KKbMkDH49FQ3c36vl
	 65V6vBAranIYh+ABOqRZFFwGCRAroOfH6V2IwaAvOvX03dRVj1um6da9yeUy3HLdT4
	 WqaHHz/gOy+q/Q2tXheNEctGbF0KRRL71GlasgP163r0qcsUdXcW1otCMtIhV4E2EO
	 NPdyk2EqUdhJJWqqDfjwrB1aJktLXE/m2EFU/ZNDB9jjNEx0YkRzRINJBY12r7DhWl
	 BTVoyePj6KotCeFK02HCMym6ZcQNqtvRB8RK39ZXF63W8b00TMLgXFI/s5mWJ8IVS7
	 AWB9RZKUBN/dg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Saket Dumbre <saket.dumbre@intel.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1] ACPICA: Update the format of Arg3 of _DSM
Date: Tue, 17 Mar 2026 20:34:49 +0100
Message-ID: <12856643.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Saket Dumbre <saket.dumbre@intel.com>

To get rid of type incompatibility warnings in Linux.

Fixes: 81f92cff6d42 ("ACPICA: ACPI_TYPE_ANY does not include the package type")
Link: https://github.com/acpica/acpica/commit/4fb74872dcec
Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/acpredef.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/acpredef.h b/drivers/acpi/acpica/acpredef.h
index 6c9b5bf7d392..07d5790d09f8 100644
--- a/drivers/acpi/acpica/acpredef.h
+++ b/drivers/acpi/acpica/acpredef.h
@@ -451,7 +451,7 @@ const union acpi_predefined_info acpi_gbl_predefined_methods[] = {
 
 	{{"_DSM",
 	  METHOD_4ARGS(ACPI_TYPE_BUFFER, ACPI_TYPE_INTEGER, ACPI_TYPE_INTEGER,
-		       ACPI_TYPE_ANY | ACPI_TYPE_PACKAGE) |
+		       ACPI_TYPE_PACKAGE | ACPI_TYPE_ANY) |
 		       ARG_COUNT_IS_MINIMUM,
 	  METHOD_RETURNS(ACPI_RTYPE_ALL)}},	/* Must return a value, but it can be of any type */
 
-- 
2.51.0




