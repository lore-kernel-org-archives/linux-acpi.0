Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C10F31A556
	for <linux-acpi@vger.kernel.org>; Fri, 20 Mar 2026 01:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773971354; cv=none; b=UnyoTTlN/rY2eeA8cGccIS6LrKnW6Uml3h3WUT7obrhD10AN3Jc3H2P4HR2rGs4s9sXC8gujmtVAR35C9HAQJiXKC9VTywqvc1l8BDdraNctarGJTpx8dU6y9K46u46zscClYRNjHFXcyFDPdXK3RWR0AQ+U3UdYajYBTmLGxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773971354; c=relaxed/simple;
	bh=OQbvRykKoNa43YZcIMYkN82VceNVnbkpf9iVoiXE4Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdhYagAPpOq0zeoT+cJMq51IgkPM5lEo+5GY+0IcpHm+NS41GNlccrtln86XkCy3T8QtX6jIcf2IrLbPBEctsTRDIH1srSwak2M0R60gPqbxyu3DYANvKtri1X87CKpE0BU2FHx2gMf1a1rXjI5F6WLKWFfma8SIyIo2zRVfXO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpGGNUPe; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpGGNUPe"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c0ea57fea7so1422570eec.0
        for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2026 18:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773971347; x=1774576147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vDLk7kc0xKTEA1c0yQsz8nqJieDB48TiTejBd9azOR8=;
        b=gpGGNUPefuS29PiYD9VFmqt+ecDPzbdX5Cvt2ITJZLKL9RgNu+gQtUS2oNkWcew8zn
         e4MKuPQPD1ftGTQD+gVB7hauGCzQFn8LI8vupdZEN56xATVRpTC5j3SjA1YNLkn6hLKO
         dedo4ZVdr/e5q2zl86/qwkSdAPXL1tfb/XqFABmUdQEBQWqUhp4iuobITEVxUIYOQOEi
         6hJK+RmCbI+i6hyIYKU13lHH9yUCHq7xxo7HG/gBsFWAPBwI88NqZ/SCkBGBeCPwqMQt
         48+CqTBkdp/dALIRMBPizSdgjYLB8kCKJ8yCBi84jp3KHG1Xgm5A2sUQ63o6nmrh8b9G
         BRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773971347; x=1774576147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDLk7kc0xKTEA1c0yQsz8nqJieDB48TiTejBd9azOR8=;
        b=o43rJxF7Dkn99VpybGbYgtVWEMq7on0CTTCoi5X9RTarfj0wU1eUVbd/0cWxriBP5F
         rA0aYeboOU5DF6EGVWIuj9E1S2htyjX3iqk3DQeQlsN1AyxTZ/mjDOCy8ydp7zeqJVhq
         +ephuRg+vLULH1KlWwFgETa9OjlWNWomIjlWSUv7zeaT8+6beAnmOGeskRcgGLpQ9qbW
         fjWl+6AmPmc0UQTp246ixowugPrTdh/vsNWh6Gkd7gLhGMmnQkH+olUqwpGg7soO3hbK
         I/jCj+uOUnfk4TwUShASeylKAvkjFPTzzsd2mjFnNiz9Xkq5uucGXMB42xgLMt72+eZS
         dz2Q==
X-Forwarded-Encrypted: i=1; AJvYcCU4OXeNDaiqzMs+yOVJQpI6IrQLif1faAgTympDyxiWHashsnSqnIempxUGnKkxLztSgp3N9E8MjSpv@vger.kernel.org
X-Gm-Message-State: AOJu0YzRqNgQTnHTGCZSrOEDYU+aCaP4vkTcm8yzNXoXtKub0SoBbs3D
	CMHe83CPxMstZlArUZB9PFBqUhhi1H+2zG+EVxTITKTV2QFiHym3iNIt
X-Gm-Gg: ATEYQzxTSwwfafN2tvTnadNLYNC2JKw/llOlQKUH7XZEw/78+l+rYa6fBRIwiNkIGVu
	KokiYNmoqi8XTJyxBv6yxLLk9fLXL6SU3OQMgoP4NgLTas9QHnMhl+dt/knDPVQOtUO43ROZOfh
	SwVD4uqTIsAlgbi52LnCD1IOcRnMta9G6FFDOSYOS6qhXkA3dGJ2rIuAqJ230b2QWFrd+O5YxJR
	N30IxWxKodS/RlJov8Z9oZsm6xva2MUnJXPuc7GAdFNz+e05pmK0IDqUC2Ir6evodgMMThWzzeA
	ngXQgJNNOaiDIP3XwSqvXzxbyijukxDb3wVPBmIBTkWfGPW+uGwUuExDEbbqfkPYpD5jucKCy0S
	r1vHzGvdeYlz9ghWvwJ7CnprwnDmTWoG9XjChUNZkKmhjD3ndCemv7Ohf3bpUTZoP6ooYW37Sjm
	r0HypWb8ayO9acRW7AEznmuuPaJVdf877criIxLAZGBHwe1IU3M/LcTh/11oZpz7DS
X-Received: by 2002:a05:7300:d704:b0:2c0:ca48:3112 with SMTP id 5a478bee46e88-2c109625c4amr667665eec.10.1773971346674;
        Thu, 19 Mar 2026 18:49:06 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:8c36:d8b0:8e30:aab7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17b8f2sm2037356eec.9.2026.03.19.18.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 18:49:05 -0700 (PDT)
Date: Thu, 19 Mar 2026 18:49:02 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 0/4] platform/x86: x86-android-tablets: use real firmware
 node references with intel drivers
Message-ID: <abyje0mhIOtDZbxO@google.com>
References: <20260319-baytrail-real-swnode-v1-0-75f2264ae49f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-baytrail-real-swnode-v1-0-75f2264ae49f@oss.qualcomm.com>

Hi Bartosz,

On Thu, Mar 19, 2026 at 05:10:53PM +0100, Bartosz Golaszewski wrote:
> Problem statement: GPIO software node lookup should rely exclusively on
> matching the addresses of the referenced firmware nodes. I tried to
> enforce it with commit e5d527be7e69 ("gpio: swnode: don't use the
> swnode's name as the key for GPIO lookup") but it broke existing
> users who abuse the software node mechanism by creating "dummy" software
> nodes named after the device they want to get GPIOs from but never
> attaching them to the actual GPIO devices. They rely on the current
> behavior of GPIOLIB where it will match the label of the GPIO controller
> against the name of the software node and does not require a true link.
> 
> x86-android-tablets driver is one of the abusers in that it creates
> dummy software nodes for baytrail and cherryview GPIO controllers but
> they don't really reference these devices. Before we can reapply
> e5d527be7e69 and support matching by fwnode address exclusively, we need
> to convert all the users to using actual fwnode references.
> 
> It's possible for drivers to reference real firmware nodes from software
> nodes via PROPERTY_ENTRY_REF() in general or PROPERTY_ENTRY_GPIO()
> specifically but for platform devices binding to real firmware nodes (DT
> or ACPI) it's cumbersome as they would need to dynamically look for the
> right nodes and create references dynamically with no way of using
> static const software nodes.
> 
> This series proposes a solution in the form of automatic secondary
> software node assignment (I'm open to better naming ideas). We extend
> the swnode API with functions allowing to set up a behind-the-scenes bus
> notifier for a group of named software nodes. It will wait for bus
> events and when a device is added, it will check its name against the
> software node's name and - on match - assign the software node as the
> secondary firmware node of the device's *real* firmware node.

The more I think about the current approaches with strict identity
matching the less I like them, and the reason is that strict identity
matching establishes rigid links between consumers and producers of
GPIOS/swnodes, and puts us into link order hell. For example, I believe
if andoird tablets drivers were in drivers/android vs
drivers/platform/... the current scheme would break since the nodes
would not be registered and GPIO lookups would fail with -ENOENT vs
-EPROBE_DEFER.

Given that this series somewhat re-introduces the name matching, I
wonder if we can not do something like the following (the rough draft):

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 51320837f3a9..b0e8923a092c 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -509,6 +509,7 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 	struct swnode *swnode = to_swnode(fwnode);
 	const struct software_node_ref_args *ref_array;
 	const struct software_node_ref_args *ref;
+	const struct software_node *ref_swnode;
 	const struct property_entry *prop;
 	struct fwnode_handle *refnode;
 	u32 nargs_prop_val;
@@ -550,7 +551,10 @@ software_node_get_reference_args(const struct fwnode_handle *fwnode,
 		refnode = software_node_fwnode(ref->swnode);
 	else if (ref->fwnode)
 		refnode = ref->fwnode;
-	else
+	else if (ref->swnode_name) {
+		ref_swnode = software_node_find_by_name(NULL, ref->swnode_name);
+		refnode = ref_swnode ? software_node_fwnode(ref_swnode) : NULL;
+	} else
 		return -EINVAL;
 
 	if (!refnode)
diff --git a/include/linux/property.h b/include/linux/property.h
index e30ef23a9af3..44e96ee47272 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -363,6 +363,7 @@ struct software_node;
 struct software_node_ref_args {
 	const struct software_node *swnode;
 	struct fwnode_handle *fwnode;
+	const char *swnode_name;
 	unsigned int nargs;
 	u64 args[NR_FWNODE_REFERENCE_ARGS];
 };
@@ -373,6 +374,9 @@ struct software_node_ref_args {
 			   const struct software_node *: _ref_,	\
 			   struct software_node *: _ref_,	\
 			   default: NULL),			\
+	.swnode_name = _Generic(_ref_,				\
+				const char *: _ref_,		\
+				default: NULL),			\
 	.fwnode = _Generic(_ref_,				\
 			   struct fwnode_handle *: _ref_,	\
 			   default: NULL),			\

This will allow consumers specify top-level software node name instead
of software node structure, and it will get resolved to concrete
firmware node. GPIOLIB can continue matching on node identity.

WDYT?

Also, you need to update the existing documentation in order to be able
to call the existing documented practice an "abuse" ;)

Thanks.

-- 
Dmitry
