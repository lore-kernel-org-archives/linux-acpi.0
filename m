Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DF62FE042;
	Mon, 12 Oct 2026 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791789423; cv=none; b=Rx5bQasQkcusgeotqCmwpFbYFNplCUGRkegNBltRdCXIKYy2q/6xmLjlDEVx2adr8+YUcnfZjBpUykdzdkBzZB3F6jKweM60UkDgojLPKwQBk1CsSXVSD4UZv7G20YCm5GzLBy1lry71WKB5J74ApyHJc8XCUhoTeQZqgOjCFV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791789423; c=relaxed/simple;
	bh=GHGRzDu1jlT6vvkm/rdVz4B+NvejExmm3Ww2ilVvNb0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=A2XXERZ726CZ2x6eSD9vU9T+Y2wzO/ehALtnYaW4wnCtBaZwLaJqZy5RZmetwfwEWJCsa6qAMap7zdcE79qDGwYf+4ZgnTL0odePjSc0RttQjnHJn/XOyjXoSWqLBUKijaxds2zpL+1W5TeZScsSdoO2M1NbbtBG888k8sSLgbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.46.54])
	by gateway (Coremail) with SMTP id _____8DxOvBkicxqudwUAA--.60737S3;
	Mon, 12 Oct 2026 15:16:52 +0800 (CST)
Received: from [10.40.46.54] (unknown [10.40.46.54])
	by front1 (Coremail) with SMTP id qMiowJDxg8xeicxqAlcrAA--.63784S2;
	Mon, 12 Oct 2026 15:16:46 +0800 (CST)
Message-ID: <10bd45f8-2d37-42f0-b7d2-a4a84933c9b3@loongson.cn>
Date: Mon, 12 Oct 2026 15:18:13 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: rafael@kernel.org, linux-acpi@vger.kernel.org
Cc: acpica-devel@lists.linux.dev, chenhuacai@kernel.org, lenb@kernel.org,
 linux-kernel@vger.kernel.org, lixianglai@loongson.cn,
 loongarch@lists.linux.dev, maciej.wieczor-retman@intel.com,
 pawel.chmielewski@intel.com, maobibo@loongson.cn
References: <20260922121058.972734-2-maobibo@loongson.cn>
Subject: Re: [PATCH v4 1/4] ACPICA: actbl2.h: Add bit constants of the Flags
 field in the IOVT IOMMU structure
Content-Language: en-US
From: Bibo Mao <maobibo@loongson.cn>
In-Reply-To: <20260922121058.972734-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:qMiowJDxg8xeicxqAlcrAA--.63784S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZw17Xw1xCry7GF1fCry8JFc_yoWDKwb_Ca
	na9F4kZ3WDWF1xtrs8t3WxArWjgayxAFZ3KFs5WFn8Aa92vrWUurnakryS9F4kC3929FWD
	ZFn8WrWF9wnxGosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r
	126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8aZX5UU
	UUU==

This change is already merged in acpica tree.

slightly ping.

On Tue, Sep 22, 2026 at 08:10:55PM +0800, Bibo Mao wrote:
 > According to the IOVT specification, define macros for each bit of the
 > Flags field in the IOVT IOMMU structure.
 >
 > Link: https://github.com/open-acpica/acpica/commit/352f750e4cc0
 > Signed-off-by: Bibo Mao <maobibo@loongson.cn>
 > ---
 >  include/acpi/actbl2.h | 7 +++++++
 >  1 file changed, 7 insertions(+)
 >
 > diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
 > index baef525367b5..76e4a5bc79b4 100644
 > --- a/include/acpi/actbl2.h
 > +++ b/include/acpi/actbl2.h
 > @@ -919,6 +919,13 @@ struct acpi_iovt_iommu {
 >       u32 device_entry_offset;
 >  };
 >
 > +/* Masks for Flags field above */
 > +#define ACPI_IOVT_IOMMU_PCI_DEVICE           (1<<0)
 > +#define ACPI_IOVT_IOMMU_PXM_VALID            (1<<1)
 > +#define ACPI_IOVT_IOMMU_MAGAGE_BY_SEGMENT    (1<<2)
 > +#define ACPI_IOVT_IOMMU_HW_CAP_SUPPORT               (1<<3)
 > +#define ACPI_IOVT_IOMMU_MSI_INT_BYPASS               (1<<4)
 > +
 >  struct acpi_iovt_device_entry {
 >       u8 type;
 >       u8 length;
 > --
 > 2.39.3
 >

