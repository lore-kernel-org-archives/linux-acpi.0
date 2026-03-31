Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3490D39D6F9;
	Tue, 31 Mar 2026 08:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944611; cv=none; b=JLAcYL/9N8zxtWnKhcUjmYKqHluLE2LXNq59zPSBww44Ufo+/ziBkY5Kk8divzyyBvYtBwbObz7dCUHAcBl1HguG5rurbwNrUf4VMVAmQddueKpO+FKDmuWam9yhHIDHQgN9qrwqLNs8KtAu0uJohG6pdTkptasiYXCgInzYRDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944611; c=relaxed/simple;
	bh=lCUIPLG9Ujiy6Hcm+ipj9eX/eyzqF2yoHYthdHr+EUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUmrmRanSPfh20xgZ0M5tf77N7yfxTgmjLG0eYYZtuNRc8ABljpnilaBAgUzLa8CpkBRkwkZRARhiLxLqgX5xPpwlzVvRgZqWA0Djsu7oT6gxYqBn3Ff1FlQdSrRfhpiX3/hE/GMF0ulC3FeCOBzA9KpWF7wFtVxbNwV64FJyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMP1CjUU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMP1CjUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8C2C19423;
	Tue, 31 Mar 2026 08:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774944610;
	bh=lCUIPLG9Ujiy6Hcm+ipj9eX/eyzqF2yoHYthdHr+EUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PMP1CjUUuq3JAeDwEU5M3xfMr5g1RZ9Vdo9Yb0BMPmbIDXET/152IW9c1tM6n7pRl
	 u8W10VB/4zyEpsENfAxfFaDG2b7mvSkt7hVBfXg3D1Px8vrFf3db+5vfj+XOchX8Jw
	 YzZxH2ym44hlzXr2/QfJDgUQGczlAGfipYWohnG80LkOT3Ux78Y7o45YkZ+s3I5swZ
	 rh5ZRhq1UK/I1oiGmIKtlbeqxkFFf1p70X6QoPsRZqU6s2k/tvjHCFNoR0IA/5kn5Y
	 +ASMY2NpD8zwItVUevhJ5ffu2nnxHT3RAXbfU40w0SIG3GhSZQAA+HciIqz6wWJZB4
	 xyk3iOLQQ/9CQ==
Date: Tue, 31 Mar 2026 10:09:59 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] x86/geode: fix on-stack property data usage
Message-ID: <acuBVz6kHGYdTWqU@gmail.com>
References: <20260329-property-gpio-fix-v2-0-3cca5ba136d8@gmail.com>
 <20260329-property-gpio-fix-v2-1-3cca5ba136d8@gmail.com>
 <actgKlES7sfLk16q@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <actgKlES7sfLk16q@google.com>


* Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Sun, Mar 29, 2026 at 07:27:48PM -0700, Dmitry Torokhov wrote:
> > The PROPERTY_ENTRY_GPIO macro (and by extension PROPERTY_ENTRY_REF)
> > creates a temporary software_node_ref_args structure on the stack
> > when used in a runtime assignment. This results in the property
> > pointing to data that is invalid once the function returns.
> > 
> > Fix this by ensuring the GPIO reference data is not stored on stack and
> > using PROPERTY_ENTRY_REF_ARRAY_LEN() to point directly to the persistent
> > reference data.
> > 
> > Fixes: 298c9babadb8 ("x86/platform/geode: switch GPIO buttons and LEDs to software properties")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> While we are discussing with Andy patches 2-4 maybe this one can be
> picked up? It does fix (I hope)(I hope)  a real issue in the field.

Agreed, I've queued it up in tip:x86/urgent.

Thanks,

	Ingo
