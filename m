Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618143A5E65
	for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789564788; cv=none; b=IF8HAN2u1JlTvcICfdeNBeWu+tbV7cEZ+VEtyqZOVAoeXmfx8AjrbwwKJlWJ5i3zt8SIkGSvF2Ue+ecpWHK0bJaCw72jt7tTHSP6phgcT9XIIr+m/DQAM8Z1HBE/hBgv/EV8s3/P6qO7J5McoCIwW2IvR2qMtv6uLIEx2HKGLQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789564788; c=relaxed/simple;
	bh=fCWw0Trjnxse44I8g0/geXOuyNpXr43fX6tn+i6FZ7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=at7vqjDlezwGogcJIZQZkfOnSRiyawJVaW3tYck5uzGelwUi1ZUpz5mCXkAYaVWmAFcIVzTgO7rwj2BACIzF46y+riq+R7p6kCijhabR/LH82d5v5y+wisgXRSIX5zxlybWvBmzMUqs96RulqTPSY+rN3umAhIdmzokFx6E25FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b3ddw9Uf; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b3ddw9Uf"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa053900f5so1675842a12.1
        for <linux-acpi@vger.kernel.org>; Wed, 16 Sep 2026 06:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789564784; x=1790169584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/g2oyb1OwyLHE2WzpJBh/jQ1AsTk6Ezgm+5y3dxq+Tw=;
        b=b3ddw9UfrwqrjZKQdivrcL7IsRbQHVgcfyFeGHsFlpyaekr3MZ6dZJqrYetG2drAWb
         PqjCrWOKKycNtnxpZhmY4w52K41AlzsA+Ser7/c2ufy95x1eGBC0BA1aqnStI731RFou
         rOIvcsv/quJqQLFCpAMEp2TMKullerHStCDF4aU/Eipsc0Lm3GD/dQ4sIXsd3ZMh0RXH
         ejmIuUU7EUFn6tXyJ2Mvr6mSv4bFIELlpywYnakWr1n1AlToDECyk5kO8hnPseBF4bV8
         YIzaiQVqULQhlAPBXk+6afXTA4NSglZHfKxxmVGC41hjP8Msm692XGXc//25fX1s67lr
         raLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789564784; x=1790169584;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/g2oyb1OwyLHE2WzpJBh/jQ1AsTk6Ezgm+5y3dxq+Tw=;
        b=2MzkschWpBgayMUd5ilmjL6syQDsQYExownO4L5mld07ldEODtWdQTBfSGi0smS6Qx
         4qNzARtf1CujW4ypdD/1kfc2oiG+Ct3h0Wc76fwAAF6VDCrXHQR7d1xEx7i/HfD1FYXr
         TN8U5zYYyth/d5yzYI5ZEpswSJqHU8KntSEEyMOuJUtGn7qJEphuosMEbqQJBOZVVV7c
         UC7SPJvir/WCPCoUZmWQm5LwHGyEAguYetCvUbrZi3/1r826cNxBLWoPGcvIHUGgqgHP
         RHtsqpuNCxoH15Q2JMyaMzk9G/7i2wlCk0tbdwrxzenn97K7XId+wZJ6xXGzg55DgMOg
         e4tw==
X-Forwarded-Encrypted: i=1; AKwUvBzkGwVOfiydRRCP3A8THfOl7Lpau/ivLIOJMZOv52bjCbXXDmEoPtO4C1EJj1vOzt+9d/jAC/M8Vtk8@vger.kernel.org
X-Gm-Message-State: AFuF++ktTFIAqcRz0XcQq7gN11XtaGRMTRkd6RbM+Ziz39D2h7tvH7Al
	WZXJ2PxCB7cYBbpXwzsrbDbGw2Fz4OuC8YWAG3lt2qC87ExxcSGMgWcDyNuynu04qGg=
X-Gm-Gg: AYBFou0jaoIhQu2w9SkXyyVjrOYi9LKAfTg6HI4qrFCTpDwcCJxiHzngcjcpWwOTnT4
	8/7Ydu2si6jLxeBld5IaEtIGUhMUo8ml7/2Jd3Kd6hRbl50RGEiPRZbB4jlqUH3JS/ARzsV+qOe
	bZ4GkZYZDgKMMW4+FTVHmV653ism7clMa9Tw20o9GMJL0QlIiJxhzhOPeYHF5YZw9R2Ght0ezRZ
	8TPsAPvEcNzTb1x/komlCdabKVoelRpIWllQgM+NrGDIU1pYcyTTFcZwmjjzu0yOWMX9bBHdr6p
	c3GbKclYrj8A0ArPA30DGUOxqkbULx41qXzLZ3sLpy9hlkiWlJakX558TiXt5ftuqsEuc1ESSeA
	X/BCJODupup/unWkPlV2nCzv81PENpgL9x//pO3sSpBYWxg8kLZyPOiI+24LC/6jDB0mHh3O3Tz
	7JUcF8k3DgIM2U7IKNDL6a3rT+iLTkWQS8ejYiSexIJ/p139tLNjUghldBFQ7E
X-Received: by 2002:a05:6402:1f12:b0:6a9:a5e7:f8d3 with SMTP id 4fb4d7f45d1cf-6aa223a42b5mr1916895a12.19.1789564784428;
        Wed, 16 Sep 2026 06:19:44 -0700 (PDT)
Received: from localhost ([2a02:aa7:4656:2314:c23c:9eda:81d:3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa1cfe07e4sm1748298a12.2.2026.09.16.06.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 06:19:44 -0700 (PDT)
Date: Wed, 16 Sep 2026 15:19:43 +0200
From: Michal Hocko <mhocko@suse.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Kyle Meyer <kyle.meyer@hpe.com>, akpm@linux-foundation.org,
	corbet@lwn.net, linmiaohe@huawei.com, shuah@kernel.org,
	tony.luck@intel.com, jane.chu@oracle.com, jiaqiyan@google.com,
	Liam.Howlett@oracle.com, bp@alien8.de, hannes@cmpxchg.org,
	jack@suse.cz, joel.granados@kernel.org, laoar.shao@gmail.com,
	lorenzo.stoakes@oracle.com, mclapinski@google.com,
	nao.horiguchi@gmail.com, osalvador@suse.de,
	rafael.j.wysocki@intel.com, rppt@kernel.org, russ.anderson@hpe.com,
	shawn.fan@intel.com, surenb@google.com, vbabka@suse.cz,
	linux-acpi@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3] mm/memory-failure: Support disabling soft offline for
 HugeTLB pages
Message-ID: <aqqXbwglwYTyTuUG@tiehlicka>
References: <aqiIEkrc6aDBOqRg@hpe.com>
 <aqkCbgHmMGxI_GLG@tiehlicka>
 <aqmGd0GGUCkbZpkZ@hpe.com>
 <aqpYxAktjexhaMGc@tiehlicka>
 <ad36cd54-7319-4bb4-bf8f-9fcc7b009158@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad36cd54-7319-4bb4-bf8f-9fcc7b009158@kernel.org>

On Wed 16-09-26 15:08:45, David Hildenbrand wrote:
> 
> > 
> > OK, so apparently there are some BIOSes which abuse this feature to
> > mimic a real HW poisoning. This doesn't change the overall picture
> > though
> 
> Is this really abusing? We know that a page is shaky and will likely go bad in
> the future, For now it is still accessible. Trying to migrate off that page stop
> using it right away sounds pretty logical to me.

Yes, no dispute on that. But we have HW poisoning for exactly that
purpose, no?

> Now, the weird thing is that for hugetlb we wants a different behavior (keep
> using the page and ignore the request to evacuate).

Exactly

-- 
Michal Hocko
SUSE Labs
