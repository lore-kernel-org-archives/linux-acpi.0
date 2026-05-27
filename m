Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0C447D93E;
	Wed, 27 May 2026 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779905530; cv=none; b=VvDtgQ/LBpLKs14lm/GSpWUqmLu02r3yD+8s1LqBbBa3jK6I8iWcxyv8rnxNKarAe8TTzFpIqS7ORw1Vk06IpwneZEfdM20SIMjQe9QpSBRaNi4MaI/b0mZojUcIzc6N/cxzAc+zKXbaQbLz/I5L4s3dbNKHzCEx/9YCP6L9jVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779905530; c=relaxed/simple;
	bh=kMK+d/NZFe1Ef0M2Q17o8Ow1S+QykR2D81AhYjMQke4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SRofnT+jrOf1KCRsMqtu/5ENouLPYJwQv4eUln/pp5pjEEJ9sYA3FR36dOR8vE+fXqztHbrZindcCEM9WFVvfphp7nPRracmkJQFDtW3EJqaBGDnpT3m8UrNkbP25myjS1QrF55HgapoDZ027PEsfvP1u+CxZvWOUh8ZXXvCXIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6e4+yIm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6e4+yIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194651F000E9;
	Wed, 27 May 2026 18:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779905529;
	bh=lpIB1qbTomFkA5M2Z7ieVQWgVFZmszY0JKwLh5xnL5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G6e4+yIm4ZgIBrLP7uf9NHD2WThGrTDgENcNvl7tlaCocbwIS42RwKn1CtSo8DIG6
	 vVD9fpp0WVY6T4ilW/atMFvYIlJbAj+Deh3fuOoVCrNpB4YZXi8AHfJO683ZRuXR1/
	 uvUtIhYcJ5/ZuYIwIz+8Qy9LxBueUuApqvYNLFBC19pjhCpLRxg/VHF7x2INzUllgK
	 3ms4cYjCo/ctPHQcH/DdF82eV3/wcAw66KJieqhqlzuAJj7d0sdq9IO8udCG6dZAuQ
	 nfk7kmYGm+g2nxNjeyi514ZyIktWOXpnMgtozrWj8qSC9ZsSxPY5p7mZlnE57nQAri
	 QDjRS4Kxy2+lw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Saket Dumbre <saket.dumbre@intel.com>,
 Pawel Chmielewski <pawel.chmielewski@intel.com>
Subject: [PATCH v1 15/27] ACPICA: Prevent adding invalid references
Date: Wed, 27 May 2026 20:01:21 +0200
Message-ID: <4511989.ejJDZkT8p0@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5998844.DvuYhMxLoT@rafael.j.wysocki>
References: <5998844.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: ikaros <void0red@gmail.com>

Prevent adding references for local, argument, and debug objects
in acpi_ut_copy_simple_object().

Link: https://github.com/acpica/acpica/commit/f576898d7814
Signed-off-by: ikaros <void0red@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpica/utcopy.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 80458e70ac2b..9ecf5c3f49ba 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -731,7 +731,15 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 			break;
 		}
 
-		acpi_ut_add_reference(source_desc->reference.object);
+		/*
+		 * Local/Arg/Debug references do not have a valid Object pointer
+		 * that can be referenced
+		 */
+		if ((source_desc->reference.class != ACPI_REFCLASS_LOCAL) &&
+		    (source_desc->reference.class != ACPI_REFCLASS_ARG) &&
+		    (source_desc->reference.class != ACPI_REFCLASS_DEBUG)) {
+			acpi_ut_add_reference(source_desc->reference.object);
+		}
 		break;
 
 	case ACPI_TYPE_REGION:
-- 
2.51.0




