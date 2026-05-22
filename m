Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3702D0C89;
	Fri, 22 May 2026 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779447165; cv=none; b=XS+6ZTMmxzh3iBdp0d7xsiB74dTs1sDIVejUFenFuMuL0bLXj7ugt+ZHjLh58cO1dp0acW1EY7vGru6D6M7tg/6aO5WKSS24bIXoC98YRh3ExDgwlJvXBfu8j3wx/wommU/K8daJOoNTJuIrORNr/zU89OFnTbdCMaBhGwJ5FEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779447165; c=relaxed/simple;
	bh=Zd7Asxic3jvY0c0wIJAuhIzVSWTrXdoT+8UgJHz9tdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgHmy0ucY+wQHpQqWfR1Nn/o6s9/l6B4Zc0jGYhrxP+D7MO3us/aurMPB61rpaAiwK0JsnKUEl1ryjX+Y6jj2SqIHp+PpNxbHn1aWBhzoAwZ/pocBmDi+z3oOVVPAfaySRWSBZKkoQAtDqL7ndSKihhwvzZcnjvZ2hxXYggurcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bZxpp2ao; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bZxpp2ao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EF41F000E9;
	Fri, 22 May 2026 10:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779447163;
	bh=UB/HlxiBZE/Go+yyULq5shu+0xUVbVmvL7M9+NPvt7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bZxpp2aoy4xwycOUGcaYcOkO8f2LYdk0YbeE8RNNA0lqBiXM5fmcqQTPH6Dozb9X6
	 pmguXv4RIpPp4Ri0h6vsb6BVeuE1sol9no7lgKmVySAF8k5AuzeqaHwX1V+R7oSnpi
	 XxN8Ww8I44Xqs256Ob1M1LrV/niEy46PrOeca7dw=
Date: Fri, 22 May 2026 12:52:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Len Brown <lenb@kernel.org>, Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>, driver-core@lists.linux.dev,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	brgl@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] device property: set fwnode->secondary to NULL in
 fwnode_init()
Message-ID: <2026052215-motto-cartridge-1370@gregkh>
References: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>
 <DICUSYTHZ339.3DW3CRNZ32K6U@kernel.org>
 <2026052254-rug-mug-24cd@gregkh>
 <3888011e-789a-40e9-b222-c5522a6b7037@kernel.org>
 <1ee68533-144c-42f2-94c8-d6ef7c1dc644@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ee68533-144c-42f2-94c8-d6ef7c1dc644@kernel.org>

On Fri, May 22, 2026 at 12:43:00PM +0200, Danilo Krummrich wrote:
> On 5/22/26 12:40 PM, Danilo Krummrich wrote:
> > On 5/22/26 12:24 PM, Greg Kroah-Hartman wrote:
> >> Sure, but for now I'll go take this one.
> > The follow-up commit 7eba000621ff ("device property: initialize the remaining
> > fields of fwnode_handle in fwnode_init()") is already in driver-core-next.
> 
> s/follow-up/v2/
> 
> https://lore.kernel.org/all/20260511074927.9473-1-bartosz.golaszewski@oss.qualcomm.com/
> 

Ugh, ok, we will have a merge conflict, but at least the bugfix will
propagate to stable trees :)

thanks,

greg "digging out from a huge email backlog" k-h
