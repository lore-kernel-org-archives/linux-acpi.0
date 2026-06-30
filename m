Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C64071E2;
	Tue, 30 Jun 2026 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816964; cv=none; b=LFhjnhgJ8pNDFxm+ytY2/c32NkaYW9VcEjl1hRN2VF8tqUlI3PYAdttE+yUjUXBKX2nvxhQSBF85kscTZ03YFoLDsHLUQ23mnXxEEMmCkwUpzC/5bYiSJRZmAH0ieAosaBpOVYA37MiDTV+MgKy0pggTeeR2cA/NhUgCXhJ8C14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816964; c=relaxed/simple;
	bh=nH2FPVZuqwa+vwMtZvdqudzPlttvyZ5wsFDag/z2n0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uS7gLoGqqR0xtecUUF5ENgSU0UxBx3PrllQctkUxC6xKITZeiAT481Yj8PVlt7+pDor8Cnaq9pz3nl/yZHFvpBKSrPp23z41iv0PKbjwatIpf/4hqwX/t8x9vK4oghmpblw8Iqf7yFV/IzSi2g9PSzyFHNEEv0XG3mrVb6N35bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/OxEb3e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/OxEb3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C3B1F000E9;
	Tue, 30 Jun 2026 10:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782816962;
	bh=x+ErKDJZBnJk0BN/YgBPDVpN7NT+yJFm0+JSzLOIJy4=;
	h=From:Date:Subject:To:Cc;
	b=L/OxEb3etSRt/QAorUEF8M3kq8Zwkbm7HMFlEI2d6mzVGkMbHR0sFH75EsQmAmaux
	 6HPuU5YzbcWqYttygaAoio8rinz8q1jcrjnHF50OVgSed9T1i0b0WKonTJM5+fZPUt
	 Sl8uBXBQfzNO1kBTNdg9tgtpHJNS58xnsAnVIR59ULzPCL6wXRsXW8s46erGhxcN44
	 naBlPCWRlgBfF1P50VgW4HDrSEuK+bB9lnTHDXX9tlIfLaOPYRa5tb4C9kBjl7mAdK
	 mDDIVlDwEQa+ZdNU+jadPiewbEbHvObwvqw05zUDsxivMCDf5Q4tjL8VeSqNi3a+wy
	 /GiIQeOm1KFfQ==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 30 Jun 2026 13:55:58 +0300
Subject: [PATCH] ACPI: NVS: replace __get_free_page() with kmalloc()
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260630-b4-acpi-v1-1-a9f59c04d221@kernel.org>
X-B4-Tracking: v=1; b=H4sIAL2gQ2oC/yXMwQrCMBAE0F8pe3YhiSXU/krxsJuudnuIJasil
 P67iR7fMDM7mBQVg7HbochbTR+5wp86SAvlu6DO1RBciC6GHrlHSpui8344zyRy4Qi1vRW56ef
 3NF3/thevkp5t3hpMJsiFclpa1AjH8QWGA02cggAAAA==
X-Change-ID: 20260624-b4-acpi-01183daee9b6
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.15.2

suspend_nvs_alloc() allocates shadow pages for saving and restoring
ACPI Non-Volatile Storage regions across suspend/resume.

These buffers can be allocated with kmalloc() as there's nothing special
about them to go directly to the page allocator.

kmalloc() provides a better API that does not require ugly casts and
kfree() does not need to know the size of the freed object.

Performance difference between kmalloc() and __get_free_pages() is not
measurable as both allocators take an object/page from a per-CPU list for
fast path allocations.

For the slow path the performance is anyway determined by the amount of
reclaim involved rather than by what allocator is used.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
This is a (tiny) part of larger work of replacing page allocator calls
with kmalloc:

My initial intention a few month ago was to remove ugly casts [1], but then
willy pointed out that Linus objected to something like this [2] and it
looks like more than a decade old technical debt.

[1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
[2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/ 

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/acpi
---
 drivers/acpi/nvs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
index 6eaad7dd0241..12aee4102696 100644
--- a/drivers/acpi/nvs.c
+++ b/drivers/acpi/nvs.c
@@ -133,7 +133,7 @@ void suspend_nvs_free(void)
 
 	list_for_each_entry(entry, &nvs_list, node)
 		if (entry->data) {
-			free_page((unsigned long)entry->data);
+			kfree(entry->data);
 			entry->data = NULL;
 			if (entry->kaddr) {
 				if (entry->unmap) {
@@ -156,7 +156,7 @@ int suspend_nvs_alloc(void)
 	struct nvs_page *entry;
 
 	list_for_each_entry(entry, &nvs_list, node) {
-		entry->data = (void *)__get_free_page(GFP_KERNEL);
+		entry->data = kmalloc(PAGE_SIZE, GFP_KERNEL);
 		if (!entry->data) {
 			suspend_nvs_free();
 			return -ENOMEM;

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260624-b4-acpi-01183daee9b6

Best regards,
--  
Sincerely yours,
Mike.

