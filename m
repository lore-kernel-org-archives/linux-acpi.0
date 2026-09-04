Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C45B1A6808;
	Fri,  4 Sep 2026 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556915; cv=none; b=SNMGen1ukDRi2XkU1Es4VYNIiPAax4nEwOEl3hepJiGuHT67930vTMeBjbgl6GkE7AGDyu2WH+ipBf9w6eJNGv4aTx9COxL8GLHx5XJCq5T9ubj/n3Bk6K4n2SZtoBUYS0PezoQuE96YLUVoemhbvIItQskRJSSRZGTulLQXFzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556915; c=relaxed/simple;
	bh=us4qeYtal2fhw+IJJx6NqEovqZ1XB9f9MSCX4yN1upk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XqX2Fxk9l56LvlXmNPo8PljWwJKjDj+d0MXTWE9we2jfmIE+bligVubfjwhF/Ot4GFsPxs2jgPUBpr/7JXKrfr5KSco9676RtMM46p1yKIjxlAvm8VSUTm95xbODULT6eWWGumGyi4PQz5UZRy4MUeh01vChW9riwgymyqi7rMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=k0NLGu/0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k0NLGu/0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=kKoOHaINlhwVoLTv92gGkMR8r2LaL+e1jAe/DtwX8bg=; b=k0NLGu/0Pra0KXsaH5coPmZPyA
	+GJpSL8Nz2t5wAtoUjvuCM/Ode/ItcYTsBMSxus3bAu7cfJJKE3JpVgALzFz4nupnHzo9XK4QaCWJ
	drOcu8MJlfnsD+iLX6ogrMdWAFUAAp1sePz43VWbt0D+6eRLl7xi6frFA5n8x4IJU40eiFgxEbRyW
	LMLVzlUkcLlD+QnnyExqdKDQIqAPxHNIIpK15SvedvjHC4aJPjePfzN53vcrLSQFAmhZ5PzHKyMbd
	8CDQUS3flrXOafk1omqgruhU4uSK+YESYABTRlzdrQFS3xn+SspsN1mGy+F6xlNPKQKO23XkQPm2J
	yYkVG1BA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2bM8-00000003JSF-4AOy;
	Fri, 04 Sep 2026 21:21:53 +0000
Message-ID: <84686c67-51ed-40d0-bd59-97bf3bc8afe3@infradead.org>
Date: Fri, 4 Sep 2026 14:21:52 -0700
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] driver core: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 driver-core@lists.linux.dev
References: <20260904111816.31254-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260904111816.31254-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/4/26 4:18 AM, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/base/property.c        | 2 +-
>  drivers/base/transport_class.c | 2 +-
>  include/linux/kernfs.h         | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

-- 
~Randy
