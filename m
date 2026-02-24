Received: from cnc.isely.net (cnc.isely.net [192.69.181.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB8E3ACA53;
	Tue, 24 Feb 2026 19:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.69.181.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771961083; cv=none; b=bgv48jOCx2/Kmb7lpQjRCZERQW1agewjeycjCoZX5y28UVraOa7vJfYi3SCw1GAhxFqw+EUaElqxbT3SeLQmskcDjvUco26KQ/ABKyfKhaXcjCWqgcR+h2P1aDIFgOYSO3J7rSvjHQeCjQvW+YyMMebB7Nuxu2V95edyJluUOlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771961083; c=relaxed/simple;
	bh=00ZnDj/iBBKgFlRYONqXKqScZEDbSYwmvXe5UwYzvxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Mime-Version:Content-Type; b=tzCWo2BjWPK78QrQzzTaIRJfJBP00hn1DdkqSy8PL/Q5FBugmfJ0Jkptd0tRoJ+MdbXsnfvtziY5NlcEJ5MXGf6D8c4zmLxgSBVEFUTA1GkybgUCq9M90xpdOLX6HLnz4dHEp3pj/3CJBky4spP/V9mIlC0MMd9BFB8qf0c+cdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=cobaltdigital.com; spf=fail smtp.mailfrom=cobaltdigital.com; dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b=CvALl9Dh; arc=none smtp.client-ip=192.69.181.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=cobaltdigital.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=cobaltdigital.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1152-bit key) header.d=isely.net header.i=@isely.net header.b="CvALl9Dh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isely.net; s=deb;
	t=1771960775; bh=tyFKUWm+MAZa+CQYbASlcC9PG59WsmXWzeekMl5SMqo=;
	h=From:To:Cc:Subject:Date;
	b=CvALl9Dh0sXEdNNWdnr0wy1aUMuhVBXQI/B6D63lfThku43BI2oDA6ppcAoEkN0eo
	 HQiorRh7JImOJZ78WP479PLwDRvcdInnntgI3XwAwACzaSxm6Cdr66yYLj1+jP57hf
	 yCU9ahXqLb0uMH3NdSKIxd0uzqxSnlaB2Aof+b+XIHvEYNYsIGE4oK4MyL7hI
Original-Subject: [PATCH 0/1] software node: Use-after-free fix in drivers/base/swnode.c
Author: mike.isely@cobaltdigital.com
Original-Cc: Mike Isely <mike.isely@cobaltdigital.com>,
  Mike Isely <isely@pobox.com>, linux-acpi@vger.kernel.org,
  linux-kernel@vger.kernel.org
Received: from cobalt1.prod.cobalt.internal (ts4-dock4.isely.net [::ffff:192.168.23.121])
  (AUTH: PLAIN isely, TLS: TLS1.3,256bits,ECDHE_RSA_AES_256_GCM_SHA384)
  by cnc.isely.net with ESMTPSA
  id 00000000000A0005.00000000699DF9C7.000069D0; Tue, 24 Feb 2026 13:19:35 -0600
From: mike.isely@cobaltdigital.com
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
  Daniel Scally <djrscally@gmail.com>,
  Heikki Krogerus <heikki.krogerus@linux.intel.com>,
  Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Mike Isely <mike.isely@cobaltdigital.com>,
  Mike Isely <isely@pobox.com>, linux-acpi@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] software node: Use-after-free fix in drivers/base/swnode.c
Date: Tue, 24 Feb 2026 13:19:21 -0600
Message-ID: <20260224191922.2972974-1-mike.isely@cobaltdigital.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

From: Mike Isely <mike.isely@cobaltdigital.com>

Correct issue in drivers/base/swnode.c that can lead to use-after-free
due to kobject reference counting error, which itself is due to
incorrect behavior with the "managed" struct swnode flag in
circumstances involving child struct device instances where the parent
struct device is managing a struct swnode.

Use-after-free in this case led to an Oops and a subsequent kernel
memory leak, but realistically it's kernel heap corruption, so any
manner of chaos can result, if left unaddressed.

This was detected in kernel 6.12, verified also in kernel 6.6.  Visual
inspection in 6.19.3 source (the latest as of right now) shows the
same issue.  The nearly trivial fix was verified in 6.12.  While this
patches against 6.19.3, IMHO this is a candidate for all LTS kernels.

Mike Isely (1):
  sofware node: Only the managing device can unreference managed
    software node

 drivers/base/swnode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.47.3

