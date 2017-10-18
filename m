From: gengdongjiu <gengdongjiu@huawei.com>
Subject: Re: [PATCH v5 1/2] acpi: apei: remove the unused dead-code for
 SEA/NMI notification type
Date: Wed, 18 Oct 2017 11:04:28 +0800
Message-ID: <642709ec-05d0-2ffd-0e2e-bcdd6b12281b@huawei.com>
References: <1508227341-15651-1-git-send-email-gengdongjiu@huawei.com>
 <20171017164336.cedso3f35lpeam7f@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:8517 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbdJRDJc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Oct 2017 23:09:32 -0400
In-Reply-To: <20171017164336.cedso3f35lpeam7f@pd.tnic>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: tbaicar@codeaurora.org, james.morse@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, robert.moore@intel.com, lv.zheng@intel.com, mark.rutland@arm.com, kristina.martsenko@arm.com, mingo@kernel.org, punit.agrawal@arm.com, stephen.boyd@linaro.org, kamensky@cisco.com, prarit@redhat.com, shiju.jose@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, devel@acpica.org, Wuquanming <wuquanming@huawei.com>, Huangshaoyu <huangshaoyu@huawei.com>

Hi,Borislav

On 2017/10/18 0:43, Borislav Petkov wrote:
>> -}
>> -
> So GHES NMI notification method is x86-only AFAIK and HAVE_ACPI_APEI_NMI
> is selected only on x86. Why are you removing those guards? Does ARM
> have ACPI_HEST_NOTIFY_NMI notification type now too?

ARM does not have ACPI_HEST_NOTIFY_NMI notification, which should only used by x86.
In the code, I see those guards are never used. As you see, if the 'CONFIG_HAVE_ACPI_APEI_NMI'
does not defined in [1], it will print error info and goto [2], in the [2], it will return error,
then the probe for GHES NMI is failed. so those guards( ghes_nmi_add() and ghes_nmi_remove()) have no chance
to execute. so I redefine them to NULL for compiling[3].

    static int ghes_probe(struct platform_device *ghes_dev)
    {
      struct acpi_hest_generic *generic;
      struct ghes *ghes = NULL;

      int rc = -EINVAL;

       switch (generic->notify.type) {
	   ...................
       case ACPI_HEST_NOTIFY_NMI:                        [1]
          if (!IS_ENABLED(CONFIG_HAVE_ACPI_APEI_NMI)) {
              pr_warn(GHES_PFX "Generic hardware error source: %d notified via NMI interrupt is not supported!\n",
                  generic->header.source_id);
              goto err;
          }
           ..............
	  }
	  switch (generic->notify.type) {
          ...............
          case ACPI_HEST_NOTIFY_NMI:
             ghes_nmi_add(ghes);
             break;
          }
          ..........
 err:                                                [2]
      if (ghes) {
          ghes_fini(ghes);
          kfree(ghes);
      }
      return rc;
    }

[3]:
-static inline void ghes_nmi_add(struct ghes *ghes)
-{
-       pr_err(GHES_PFX "ID: %d, trying to add NMI notification which is not supported!\n",
-              ghes->generic->header.source_id);
-       BUG();
-}
-
-static inline void ghes_nmi_remove(struct ghes *ghes)
-{
-       pr_err(GHES_PFX "ID: %d, trying to remove NMI notification which is not supported!\n",
-              ghes->generic->header.source_id);
-       BUG();
-}
-
-static inline void ghes_nmi_init_cxt(void)
-{
-}
+static inline void ghes_nmi_add(struct ghes *ghes) { }
+static inline void ghes_nmi_remove(struct ghes *ghes) { }
+static inline void ghes_nmi_init_cxt(void) { }




